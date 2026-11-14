# Linux layer: standalone home-manager on a non-NixOS distro (Arch, WSL, servers).
{ pkgs, link, ... }: {
  programs.home-manager.enable = true;
  targets.genericLinux.enable = true;

  xdg.configFile."clangd/config.yaml".source = link "config/clangd/config.yaml";

  services.gpg-agent.pinentry.package = pkgs.pinentry-curses;
}
