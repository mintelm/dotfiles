# macOS layer: OS specifics.
{ pkgs, link, ... }: {
  # clangd reads its user config from here on macOS
  home.file."Library/Preferences/clangd/config.yaml".source = link "config/clangd/config.yaml";

  services.gpg-agent.pinentry.package = pkgs.pinentry_mac;
}
