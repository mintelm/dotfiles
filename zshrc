# {{{ GENERAL
HISTFILE=~/.cache/zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

set -o emacs

case $TERM in
  xterm*)
    precmd () {print -Pn "\e]0;%~\a"}
    ;;
esac

eval "$(dircolors)"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

bindkey "^[[3~" delete-char
bindkey '^[[Z' reverse-menu-complete
# }}}


# {{{ PROMPT
autoload -U colors && colors
setopt PROMPT_SUBST

git_branch() {
  git symbolic-ref --short HEAD 2> /dev/null | sed 's/.*/ (&)/'
}
git_dirty() {
  [[ $(git diff --shortstat 2> /dev/null | tail -n1) != "" ]] && echo "*"
}

TOKEN="{}"
PROMPT="%(?:%{$fg_bold[green]%}$TOKEN :%{$fg_bold[red]%}$TOKEN )"
PROMPT+='%{$fg[cyan]%}%c%{$fg[red]%}$(git_branch)%{$fg[yellow]%}$(git_dirty)%{$reset_color%} '
# }}}


# {{{ FUZZY FINDER 
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' \
  'm:{a-z\-}={A-Z\_}' \
  'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' \
  'r:|?=** m:{a-z\-}={A-Z\_}'
# }}}


# {{{ DIRSTACK
zstyle ':chpwd:*' recent-dirs-max 10
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
# }}}


# {{{ EXPORTS
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

if [[ -n $SSH_CONNECTION ]]; then
 export EDITOR='vim'
else
 export EDITOR='nvim'
fi
# }}}


# {{{ KEYBINDS
bindkey '^R' history-incremental-pattern-search-backward
# }}}


# {{{ ALIASES
alias sudo="sudo "
alias lock="i3lock-fancy-multimonitor -n -p"
alias open="xdg-open"
alias grep='grep  --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}'
alias wttr="curl wttr.in/regensburg"
alias vvim="vim"

if [ -x "$(command -v nvim)" ]; then
  alias vim="nvim"
fi

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
# }}}


# {{{ SOURCING
[ -d "/usr/share/zsh/plugins/zsh-syntax-highlighting" ] && \
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -d "/usr/share/zsh/plugins/zsh-autosuggestions" ] && \
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f ~/.config/zshrc.local ] && source ~/.config/zshrc.local
# }}}
