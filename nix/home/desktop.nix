# Desktop layer: GUI app configs (the apps are installed per OS).
{ link, ... }: {
  xdg.configFile."ghostty/config".source = link "config/ghostty/config";
}
