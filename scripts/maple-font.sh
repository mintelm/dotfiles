#!/usr/bin/env bash
# Builds and installs a custom Maple Mono: no ligatures, unhinted, Nerd Font
# icons, character variants frozen in. Resulting family: "Maple Mono NL NF".
# Installs to ~/Library/Fonts (macOS), ~/.local/share/fonts (Linux) or into
# Windows for the current user (WSL).
set -euo pipefail

MAPLE_VERSION="v7.9"
MAPLE_ARGS=(--no-liga --no-hinted --nf --ttf-only --feat cv01,cv32,cv35,cv36,ss06)

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
SRC="$SCRIPT_DIR/../build/maple-font"
NIX_FLAGS=(--extra-experimental-features "nix-command flakes")

if ! command -v nix &> /dev/null; then
    echo "Error: nix is required (it provides python for the build)."
    exit 1
fi

echo "Building Maple Mono $MAPLE_VERSION"
rm -rf "$SRC"
git clone --depth 1 -b "$MAPLE_VERSION" https://github.com/subframe7536/maple-font "$SRC"
# the build needs python >= 3.10 (macOS ships 3.9), so take it from nix
(
    cd "$SRC"
    nix "${NIX_FLAGS[@]}" shell nixpkgs#python3 -c bash -euc '
        python3 -m venv venv
        source venv/bin/activate
        pip install -q -r requirements.txt
        python build.py "$@"
    ' _ "${MAPLE_ARGS[@]}"
)
FONTS="$SRC/fonts/NF"

if grep -qi microsoft /proc/version 2> /dev/null; then
    # WSL: the terminal is a Windows app, so install the fonts into Windows
    powershell.exe -NoProfile -ExecutionPolicy Bypass \
        -File "$(wslpath -w "$SCRIPT_DIR/install-fonts.ps1")" -Src "$(wslpath -w "$FONTS")"
    echo "Installed 'Maple Mono NL NF' into Windows. Restart Windows Terminal and select it in the profile settings."
else
    case "$(uname -s)" in
        Darwin) font_dir="$HOME/Library/Fonts" ;;
        *) font_dir="$HOME/.local/share/fonts/maple" ;;
    esac
    mkdir -p "$font_dir"
    cp "$FONTS"/*.ttf "$font_dir/"
    if command -v fc-cache &> /dev/null; then
        fc-cache -f "$font_dir"
    fi
    echo "Installed 'Maple Mono NL NF' to $font_dir. Restart apps to pick it up."
fi
