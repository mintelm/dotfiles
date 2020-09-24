# general
fpath+=(~/.zsh)
title() { export TITLE="$*" }
precmd() { print -Pn "\e]2;%(!.@@@ .)%~\a" }
set -o emacs

# history settings
HISTFILE=~/.cache/zsh_history
HISTSIZE=50000
SAVEHIST=10000
setopt appendhistory
setopt sharehistory
setopt histfcntllock
setopt histignorealldups

# exports
if [[ -x "$(command -v nvim)" ]]; then
    export EDITOR='nvim'
else
    export EDITOR='vim'
fi
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export ZSH_AUTOSUGGEST_USE_ASYNC=1

# source it up
source ~/.zsh/plugin-loader.zsh
source ~/.zsh/keybinds.zsh
source ~/.zsh/aliases.zsh
source ~/.zsh/prompt.zsh
source ~/.zsh/fzf.zsh
source ~/.zsh/lsd.zsh
source ~/.zsh/completion-list-colors.zsh
source ~/.zsh/manydots-magic.zsh
source ~/.zsh/lfcd.zsh
