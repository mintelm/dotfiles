open() { xdg-open "$*" & disown }
# Add 'Q' bind to ranger to exit ranger and change directory.
if [ -x "$(command -v ranger)" ]; then
    ranger() {
        local IFS=$'\t\n'
        local tempfile="$(mktemp -t tmp.XXXXXX)"
        local ranger_cmd=(
            command
            ranger
            --cmd="map Q chain shell echo %d > "$tempfile"; quitall"
        )

        ${ranger_cmd[@]} "$@"
        if [[ -f "$tempfile" ]] && [[ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]]; then
            cd -- "$(cat "$tempfile")" || return
        fi
        command rm -f -- "$tempfile" 2>/dev/null
    }
    alias rr="ranger"
fi
if [ -x "$(command -v fzf)" ]; then
    alias ff='${EDITOR} $(fzf --preview "bat --color=always {}" --preview-window "~3")'
fi
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
if [ -x "$(command -v eza)" ]; then
    alias ls="eza --group-directories-first"
    alias ll="eza --group-directories-first --icons -l"
    alias lla="eza --group-directories-first --icons -la"
    alias llg="eza --group-directories-first --git --git-ignore --no-permissions --no-filesize --no-user -l"
    alias lt="eza --group-directories-first --icons --tree --level=5"
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
# WSL only aliases
if [ -f "/etc/wsl.conf" ]; then
    alias gopen='explorer.exe $(git remote get-url origin | sed "s/git@\\(.*\\):/https:\\/\\/\\1\\//")'
fi
