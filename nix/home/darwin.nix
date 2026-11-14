# macOS layer: OS specifics plus the GUI apps (a Mac is always a desktop).
{ pkgs, link, ... }: {
  home.packages = with pkgs; [
    ghostty-bin # the source build is Linux-only
    firefox-bin-unwrapped # the wrapper strips Mozilla's signature
  ];

  # clangd reads its user config from here on macOS
  home.file."Library/Preferences/clangd/config.yaml".source = link "config/clangd/config.yaml";

  services.gpg-agent.pinentry.package = pkgs.pinentry_mac;
}
