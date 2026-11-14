# Terminal layer (every machine): dotfiles, CLI tools, language servers, gpg.
{ config, lib, pkgs, inputs, ... }:
let
  unstable = import inputs.nixpkgs-unstable {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };

  # links point at the working copy, so edits apply without a rebuild
  link = path: config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/mintelm/dotfiles/${path}";

  # link every file of a repo dir into `target/` (only git-tracked files are visible)
  linkDir = dir: target:
    lib.mapAttrs' (name: _: lib.nameValuePair "${target}/${name}" { source = link "${dir}/${name}"; })
      (lib.filterAttrs (_: type: type == "regular") (builtins.readDir ../../${dir}));
in {
  _module.args.link = link; # shared with the other layers

  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    neovim
    tree-sitter

    # language servers
    bash-language-server
    clang-tools
    cmake-language-server
    lua-language-server
    pyright

    # cli
    bat
    delta
    eza
    fd
    fzf
    git
    git-absorb
    lesspipe
    ripgrep
    tig
    tmux

    unstable.claude-code
  ];

  home.file = {
    # sourced from zshrc after compinit; fzf-tab before widget wrappers, syntax-highlighting last
    ".zsh/plugins.zsh".text = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh
      source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
      source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    '';

    ".zshrc".source = link "config/zsh/zshrc";
    ".zshenv".source = link "config/zsh/zshenv";
    ".ssh/config".source = link "config/ssh/config";
  }
  // linkDir "config/zsh" ".zsh";

  # single files, since nix or the app put other files next to them
  xdg.configFile = {
    "tmux/plugins.conf".text = ''
      run-shell ${pkgs.tmuxPlugins.catppuccin.rtp}
    '';

    "nvim".source = link "config/nvim";
    "tmux/tmux.conf".source = link "config/tmux/tmux.conf";
    "bat/config".source = link "config/bat/config";
    "git/config".source = link "config/git/config";
    "tig/config".source = link "config/tig/config";
  };

  # pinentry is set per OS
  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 3600;
    maxCacheTtl = 28800;
  };
}
