# macOS system layer (nix-darwin): nix itself, shell integration, sudo, Homebrew casks.
{ lib, pkgs, self, user, ... }:
let
  # Company CA chain (TLS proxy), kept outside the repo. Optional: machines
  # without it just skip it. Reading it needs --impure.
  companyCa = /Users/${user}/.local/share/certs/company-ca.pem;
  hasCompanyCa = builtins.pathExists companyCa;
in {
  security.pki.certificateFiles = lib.optional hasCompanyCa companyCa;

  # Apps that update themselves: a nix copy gets rolled back by the next
  # activation. Homebrew itself is not installed by nix.
  homebrew = {
    enable = true;
    casks = [ "firefox" "ghostty" ];
    # this list is authoritative: anything else installed with brew is removed
    onActivation.cleanup = "uninstall";
  };

  nix.package = pkgs.lixPackageSets.latest.lix;
  nix.settings.experimental-features = "nix-command flakes";
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 30d";
  };
  nix.optimise.automatic = true;

  # Keep zsh enabled so /etc/zshenv puts nix on PATH, but leave completion
  # and prompt to ~/.zshrc (otherwise compinit runs twice, prompt is overridden).
  programs.zsh = {
    enable = true;
    enableCompletion = false;
    enableBashCompletion = false;
    promptInit = "";
  };

  # sudo via Touch ID; reattach makes it work inside tmux too
  security.pam.services.sudo_local = {
    touchIdAuth = true;
    reattach = true;
  };

  system.primaryUser = user;
  users.users.${user}.home = "/Users/${user}";

  system.configurationRevision = self.rev or self.dirtyRev or null;
  system.stateVersion = 7;
}
