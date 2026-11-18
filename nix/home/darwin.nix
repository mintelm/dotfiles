# macOS layer: OS specifics (the GUI apps are Homebrew casks in system/darwin.nix).
{ pkgs, link, ... }: {
  home.packages = with pkgs; [
    # docker engine in a Linux VM
    colima
    docker
    devcontainer
  ];

  # clangd reads its user config from here on macOS
  home.file."Library/Preferences/clangd/config.yaml".source = link "config/clangd/config.yaml";

  # a template: colima rewrites instance configs, but not this
  home.file.".colima/_templates/default.yaml".source = link "config/colima/colima.yaml";

  services.gpg-agent.pinentry.package = pkgs.pinentry_mac;
}
