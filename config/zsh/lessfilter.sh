#!/usr/bin/env bash
# This script uses eza, chafa, bat, and lesspipe.sh to provide a rich preview of
# files and directories for less and fzf-tab.

has_cmd() { command -v "$1" &> /dev/null || { echo "$1 is not installed"; return 1; }; }

# Ubuntu uses 'batcat' instead of 'bat'
BAT=$(command -v bat || command -v batcat)
MIME=$(file -bL --mime-type "$1")
CATEGORY=${MIME%%/*}
BAT_CMD="$BAT --color=always -p"

if [[ -d "$1" ]]; then
    has_cmd eza && eza -1 --color=always --git --icons --group-directories-first "$1"
elif [[ "$CATEGORY" == "image" ]]; then
    has_cmd chafa && chafa "$1"
elif [[ "$CATEGORY" == "text" ]]; then
    [[ -n "$BAT" ]] && $BAT_CMD "$1"
else
    has_cmd lesspipe.sh && [[ -n "$BAT" ]] && lesspipe.sh "$1" | $BAT_CMD
fi
