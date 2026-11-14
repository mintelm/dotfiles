alias sudo="sudo "
alias ssh='TERM=xterm-256color \ssh'
alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}'
alias wttr="curl wttr.in/regensburg"
if [ -x "$(command -v nvim)" ]; then
    alias vim="nvim"
    alias vvim="command vim"
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
    alias ccat="command cat"
fi
