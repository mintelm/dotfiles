alias plugpull="find ${ZDOTDIR:-$HOME}/.zsh_plugins -type d -exec test -e '{}/.git' ';' -print0 | xargs -I {} -0 git -C {} pull"
alias sudo="sudo "
alias ssh='TERM=xterm-256color \ssh'
alias open="xdg-open"
alias grep='grep  --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}'
alias wttr="curl wttr.in/regensburg"
alias vvim="/usr/bin/vim"
alias tmux="tmux -f ~/.config/tmux.conf"
alias screen="screen -c ~/.config/screenrc"
alias intel="optimus-manager --no-confirm --switch intel"
alias nvidia="optimus-manager --no-confirm --switch nvidia"
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
