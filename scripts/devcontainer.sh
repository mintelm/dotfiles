#!/usr/bin/env bash
# Lightweight setup of these dotfiles inside a devcontainer (Debian/Ubuntu, no
# nix): shell tools via apt, zsh plugins, and links to the configs in this repo,
# mirroring nix/home/terminal.nix. Run by the devcontainer dotfiles mechanism.
set -euo pipefail

DOTFILES="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
SUDO=$([ "$(id -u)" = 0 ] || echo sudo)

$SUDO apt-get update -qq
$SUDO env DEBIAN_FRONTEND=noninteractive apt-get install -y -qq --no-install-recommends \
    git zsh fzf bat eza ripgrep fd-find git-delta zsh-autosuggestions zsh-syntax-highlighting

# Ubuntu renames these binaries
mkdir -p ~/.local/bin
ln -sf /usr/bin/batcat ~/.local/bin/bat
ln -sf /usr/bin/fdfind ~/.local/bin/fd

# zsh plugins Ubuntu doesn't package
plugins=~/.local/share/zsh-plugins
mkdir -p "$plugins"
[ -d "$plugins/powerlevel10k" ] || git clone -q --depth 1 https://github.com/romkatv/powerlevel10k "$plugins/powerlevel10k"
[ -d "$plugins/fzf-tab" ] || git clone -q --depth 1 https://github.com/Aloxaf/fzf-tab "$plugins/fzf-tab"

# configs, linked like nix/home/terminal.nix does
mkdir -p ~/.zsh ~/.config/bat ~/.cache
for f in "$DOTFILES"/config/zsh/*; do ln -sf "$f" ~/.zsh/; done
ln -sf "$DOTFILES/config/zsh/zshrc" ~/.zshrc
ln -sf "$DOTFILES/config/zsh/zshenv" ~/.zshenv
ln -sf "$DOTFILES/config/bat/config" ~/.config/bat/config

# apt's bat doesn't bundle the Catppuccin themes
themes=~/.config/bat/themes
[ -d "$themes/catppuccin" ] || git clone -q --depth 1 https://github.com/catppuccin/bat "$themes/catppuccin"
~/.local/bin/bat cache --build > /dev/null

# same order as plugins.zsh in nix/home/terminal.nix
cat > ~/.zsh/plugins.zsh << EOF
source $plugins/powerlevel10k/powerlevel10k.zsh-theme
source $plugins/fzf-tab/fzf-tab.plugin.zsh
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
EOF

$SUDO chsh -s "$(command -v zsh)" "$(id -un)"
