open() { xdg-open "$*" & disown }
alias plugpull="find ${ZDOTDIR:-$HOME}/.zsh_plugins -type d -exec test -e '{}/.git' ';' -print0 | xargs -I {} -0 git -C {} pull"
alias sudo="sudo "
alias ssh='TERM=xterm-256color \ssh'
alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}'
alias wttr="curl wttr.in/regensburg"
alias vvim="/usr/bin/vim"
alias ccat"/usr/bin/cat"
alias tmux="tmux -f ~/.config/tmux.conf"
alias screen="screen -c ~/.config/screenrc"
alias Make="make"
alias intel="optimus-manager --no-confirm --switch intel"
alias nvidia="optimus-manager --no-confirm --switch nvidia"
alias dkup='docker-compose -f docker-compose.yml up -d'
alias dkdown='docker-compose -f docker-compose.yml stop'
alias dkpull='docker-compose -f docker-compose.yml pull'
alias dklogs='docker-compose -f docker-compose.yml logs -tf --tail="50"'
alias dktail='docker logs -tf --tail="50" "$@"'
if [ -x "$(command -v nvim)" ]; then
    alias vim="nvim"
    alias vimdiff="nvim -d"
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
if [ -x "$(command -v bat)" ]; then
    alias cat="bat"
fi
alias pacmanmirrors='export TMPFILE="$(mktemp)"; \
    sudo true; \
    rate-mirrors --save=$TMPFILE arch --max-delay=21600 \
      && sudo mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist-backup \
      && sudo mv $TMPFILE /etc/pacman.d/mirrorlist'
