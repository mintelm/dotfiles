## My Dotfiles
Configuration for macOS and Linux, managed with [Nix](https://lix.systems):
[nix-darwin](https://github.com/nix-darwin/nix-darwin) on macOS and
[home-manager](https://github.com/nix-community/home-manager) on both.

The config files stay plain files in `config/<app>/`, laid out like `~/.config`.
Home-manager symlinks them into place, so edits take effect without a rebuild.
Nix installs the tools, zsh/tmux plugins and language servers.

### Layout
Each machine is a combination of layers:

| Layer | Contents | Used by |
|---|---|---|
| `home/terminal.nix` | dotfiles, CLI tools, language servers, gpg, ssh | every machine |
| `home/desktop.nix` | GUI app configs (Ghostty) | desktops |
| `home/darwin.nix` | macOS specifics + GUI apps | Macs |
| `home/linux.nix` | Linux specifics | Linux machines |

```
config/<app>/         # dotfiles, one folder per app (bat, git, nvim, tmux, zsh, ...)
scripts/              # font build (scripts/maple-font.sh)
nix/
  flake.nix           # inputs, machine definitions, mkDarwin / mkHome helpers
  home/*.nix          # home-manager layers (see table)
  system/darwin.nix   # nix-darwin system config (nix, zsh, sudo Touch ID)
```

Machines in `nix/flake.nix`:
- **Mac** (`darwinConfigurations`): nix-darwin + home-manager, e.g. `mac`.
- **Linux** (`homeConfigurations`, named by role like `arch` or `wsl`):
  standalone home-manager, the distro owns the system. Desktops add `desktop.nix`.

### Installation
1. Install [Lix](https://lix.systems/install/) (or Nix).
2. Clone this repo to `~/mintelm/dotfiles`. The symlinks expect this path.
3. On Linux, add the machine to `homeConfigurations` in `nix/flake.nix`
   (examples are in the file):
   ```nix
   arch = mkHome {
     user = "USER";
     home = [ ./home/terminal.nix ./home/linux.nix ];  # + ./home/desktop.nix on a desktop
   };
   ```
   On Arch, also install zsh and the GUI apps (`ghostty`, `firefox`) with
   pacman: nix GUI apps can't use the system's graphics drivers outside NixOS.
4. Run:
   ```bash
   ./install.sh [-c NAME] [-b]   # see ./install.sh -h
   ```
   On Linux pass `-c NAME` on the first run; it is remembered in `nix/.machine`.

After the first run, apply changes to the nix files with `./install.sh` again, or:
```bash
# macOS
sudo darwin-rebuild switch --flake ~/mintelm/dotfiles/nix#mac --impure
# Linux
home-manager switch --flake ~/mintelm/dotfiles/nix#$(cat ~/mintelm/dotfiles/nix/.machine)
```

Notes:
- Nix only sees files tracked by git. `git add` new files before rebuilding.
- `--impure` is needed on macOS to read the optional company CA chain from
  `~/.local/share/certs/company-ca.pem` (outside the repo; skipped if missing).
- Machine-local shell settings can go in `~/.zsh/local.zsh` (plain file, not in the repo).

### Updating
```bash
cd ~/mintelm/dotfiles/nix && nix flake update
```
Then switch as above. Neovim plugins are still managed by lazy.nvim (`:Lazy`).

### Fonts
`scripts/maple-font.sh` (or `./install.sh -b`) builds and installs a custom
[Maple Mono](https://github.com/subframe7536/maple-font) (`Maple Mono NL NF`);
version and options are at the top of the script. On WSL it installs into Windows.
