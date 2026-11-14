{
  description = "Mac and Linux config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";
    nixpkgs-linux.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs-linux, nix-darwin, home-manager, ... }:

  let
    # macOS: nix-darwin system + home-manager
    mkDarwin = { user, home, system ? "aarch64-darwin" }: nix-darwin.lib.darwinSystem {
      specialArgs = { inherit self user; };
      modules = [
        ./system/darwin.nix
        { nixpkgs.hostPlatform = system; }
        home-manager.darwinModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "backup";
            extraSpecialArgs = { inherit inputs; };
            users.${user}.imports = home;
          };
        }
      ];
    };

    # Linux (Arch, WSL, servers): standalone home-manager, the distro owns the system
    mkHome = { user, home, system ? "x86_64-linux" }: home-manager.lib.homeManagerConfiguration {
      # the -darwin branch is only tested/cached for macOS
      pkgs = nixpkgs-linux.legacyPackages.${system};
      extraSpecialArgs = { inherit inputs; };
      modules = home ++ [ { home.username = user; home.homeDirectory = "/home/${user}"; } ];
    };
  in {
    darwinConfigurations = {
      mac = mkDarwin {
        user = "Mario.Mintel";
        home = [ ./home/terminal.nix ./home/darwin.nix ];
      };
    };

    # named by role, not hostname (public repo); select with `./install.sh -c NAME`
    homeConfigurations = {
      # terminal only (server, WSL):
      # wsl = mkHome {
      #   user = "USER";
      #   home = [ ./home/terminal.nix ./home/linux.nix ];
      # };
    };
  };
}
