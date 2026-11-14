#!/usr/bin/env bash
set -euo pipefail

usage() {
    printf "Usage: %s [-c NAME] [-b] [-h]\n\n" "$0"
    printf "Applies the nix configuration for this machine.\n\n"
    printf "Options:\n"
    printf "    -c: configuration from nix/flake.nix; remembered for later runs\n"
    printf "        (default: the remembered one, else 'mac' on macOS)\n"
    printf "    -b: also build and install the custom Maple Mono font (scripts/maple-font.sh)\n"
    printf "    -h: show this help\n"
    exit "${1:-1}"
}

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
EXPECTED_DIR="$HOME/mintelm/dotfiles"
FLAKE="$SCRIPT_DIR/nix"
NIX_FLAGS=(--extra-experimental-features "nix-command flakes")
# remembers the chosen configuration (gitignored, so no hostnames in the repo)
CONFIG_FILE="$FLAKE/.machine"

build=0
config=""
while getopts "c:bh" opt; do
    case "$opt" in
        c) config="$OPTARG" ;;
        b) build=1 ;;
        h) usage 0 ;;
        *) usage ;;
    esac
done

# The symlinks created by home-manager point to this fixed location
if [[ "$SCRIPT_DIR" != "$EXPECTED_DIR" ]]; then
    echo "Error: this repo must be cloned to $EXPECTED_DIR (found at $SCRIPT_DIR)."
    exit 1
fi

if ! command -v nix &> /dev/null; then
    echo "Error: nix is not installed. Install Lix first:"
    echo "    https://lix.systems/install/"
    exit 1
fi

# -c NAME > remembered name > OS default (none on Linux)
if [[ -z "$config" && -f "$CONFIG_FILE" ]]; then
    config="$(< "$CONFIG_FILE")"
fi

# exits with the available names if nix/flake.nix has no such configuration;
# otherwise remembers the name for the next run
require_config() {
    local kind="$1" name="$2"
    if [[ -z "$name" ]] || ! nix "${NIX_FLAGS[@]}" eval --impure "$FLAKE#$kind" --apply "c: c ? \"$name\"" | grep -q true; then
        [[ -n "$name" ]] && echo "Error: no $kind.\"$name\" in nix/flake.nix."
        echo "Pick a configuration with -c NAME. Available:"
        nix "${NIX_FLAGS[@]}" eval --impure --raw "$FLAKE#$kind" \
            --apply 'c: builtins.concatStringsSep "\n" (map (n: "    " + n) (builtins.attrNames c)) + "\n"'
        exit 1
    fi
    echo "$name" > "$CONFIG_FILE"
}

case "$(uname -s)" in
    Darwin)
        config="${config:-mac}"
        require_config darwinConfigurations "$config"
        echo "Applying nix-darwin configuration '$config'"
        if command -v darwin-rebuild &> /dev/null; then
            sudo darwin-rebuild switch --flake "$FLAKE#$config" --impure
        else
            # first run: darwin-rebuild is not installed yet
            sudo nix "${NIX_FLAGS[@]}" run nix-darwin/nix-darwin-26.05#darwin-rebuild -- \
                switch --flake "$FLAKE#$config" --impure
        fi
        ;;
    Linux)
        require_config homeConfigurations "$config"
        echo "Applying home-manager configuration '$config'"
        if command -v home-manager &> /dev/null; then
            home-manager switch --flake "$FLAKE#$config"
        else
            # first run: home-manager is not installed yet
            nix "${NIX_FLAGS[@]}" run home-manager/release-26.05 -- switch --flake "$FLAKE#$config"
        fi
        ;;
    *)
        echo "Error: unsupported OS $(uname -s)"
        exit 1
        ;;
esac

# build and install the custom Maple Mono font
if (( build )); then
    "$SCRIPT_DIR/scripts/maple-font.sh"
fi
