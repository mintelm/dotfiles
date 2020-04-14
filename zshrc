# {{{ AUTOLOADS
autoload -Uz colors && colors
autoload -Uz add-zsh-hook
autoload -Uz compinit && compinit
autoload -Uz chpwd_recent_dirs cdr
# }}}


# {{{ PLUGIN INIT
# assumes github and slash separated plugin names
github_plugins=(
    romkatv/gitstatus
    zsh-users/zsh-autosuggestions
    zsh-users/zsh-syntax-highlighting
)

for plugin in $github_plugins; do
    # clone the plugin from github if it doesn't exist
    if [[ ! -d ${ZDOTDIR:-$HOME}/.zsh_plugins/$plugin ]]; then
        mkdir -p ${ZDOTDIR:-$HOME}/.zsh_plugins/${plugin%/*}
        git clone --depth 1 --recursive https://github.com/$plugin.git ${ZDOTDIR:-$HOME}/.zsh_plugins/$plugin
    fi
    # load the plugin
    for initscript in ${plugin#*/}.zsh ${plugin#*/}.plugin.zsh ${plugin#*/}.sh; do
        if [[ -f ${ZDOTDIR:-$HOME}/.zsh_plugins/$plugin/$initscript ]]; then
            source ${ZDOTDIR:-$HOME}/.zsh_plugins/$plugin/$initscript
            break
        fi
    done
done

# clean up
unset github_plugins
unset plugin
unset initscript
# }}}


# {{{ SOURCING
[ -f ~/.config/zshrc.local ] && source ~/.config/zshrc.local
# }}}


# {{{ GENERAL
HISTFILE=~/.cache/zsh_history
HISTSIZE=50000
SAVEHIST=10000
setopt appendhistory
setopt extendedhistory
setopt sharehistory
setopt incappendhistory

set -o emacs

title() { export TITLE="$*" }
precmd () { print -Pn "\e]2;%(!.@@@ .)%~\a" }
[[ -n $SSH_CONNECTION ]] && precmd () { print -Pn "\e]2;%n@%m: %~\a" }

# http://zsh.sourceforge.net/Doc/Release/Zsh-Modules.html#The-zsh_002fcomplist-Module
# https://askubuntu.com/questions/17299/what-do-the-different-colors-mean-in-ls
zstyle ':completion:*' list-colors 'di=34;01:ln=36:so=32:pi=33:ex=33;01:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
# }}}


# {{{ PROMPT
setopt PROMPT_SUBST

function set_prompt() {
    TOKEN="{}"
    PROMPT="%(?:%{$fg_bold[green]%}$TOKEN :%{$fg_bold[red]%}$TOKEN )"
    PROMPT+='%{$fg[cyan]%}%c'

    if gitstatus_query MY && [[ $VCS_STATUS_RESULT == ok-sync ]]; then
        PROMPT+='%{$fg[red]%}('
        PROMPT+=${${VCS_STATUS_LOCAL_BRANCH:-@${VCS_STATUS_COMMIT}}//\%/%%}
        PROMPT+=')'
        (( $VCS_STATUS_NUM_UNSTAGED  )) || (( $VCS_STATUS_NUM_UNTRACKED )) && PROMPT+='%{$fg[yellow]%}*'
    fi
    PROMPT+='%{$reset_color%} '
}

gitstatus_stop 'MY' && gitstatus_start -s -1 -u -1 -c -1 -d -1 'MY'
add-zsh-hook precmd set_prompt
# }}}


# {{{ FUZZY FINDER 
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' \
    'm:{a-z\-}={A-Z\_}' \
    'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' \
    'r:|?=** m:{a-z\-}={A-Z\_}'
# }}}


# {{{ DIRSTACK
zstyle ':chpwd:*' recent-dirs-max 10
add-zsh-hook chpwd chpwd_recent_dirs
# }}}


# {{{ EXPORTS
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export ZSH_AUTOSUGGEST_USE_ASYNC=1
export EDITOR='nvim'
[[ -n $SSH_CONNECTION ]] && export EDITOR='vim'
# }}}


# {{{ KEYBINDS
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey '^R' history-incremental-pattern-search-backward
bindkey "^[[3~" delete-char
bindkey '^[[Z' reverse-menu-complete
# }}}


# {{{ ALIASES
alias plugpull="find ${ZDOTDIR:-$HOME}/.zsh_plugins -type d -exec test -e '{}/.git' ';' -print0 | xargs -I {} -0 git -C {} pull"
alias sudo="sudo "
alias ssh='TERM=xterm-256color \ssh'
alias lock="i3lock-fancy-multimonitor -n -p"
alias open="xdg-open"
alias grep='grep  --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}'
alias wttr="curl wttr.in/regensburg"
alias vvim="vim"

[ -x "$(command -v nvim)" ] && alias vim="nvim"

if [ -x "$(command -v exa)" ]; then
    alias ls="exa "
    alias ll="exa --icons -l"
    alias lla="exa --icons -la"
    alias llg="exa --git --git-ignore --no-permissions --no-filesize --no-user -l"
    alias lt="exa --icons --tree --level=5"
else
    alias ls="ls --color=tty"
    alias ll="ls --color=tty -lh"
    alias lla="ls --color=tty -lah"
fi

lsd() {
    if [ -z "$1" ]; then
        cdr -l
    else
        if [ "$1" ]; then
            cdr $1
        fi
    fi
}
# }}}
