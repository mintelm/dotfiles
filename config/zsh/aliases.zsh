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

# devcontainer of the current project: prefer a personal
# .devcontainer-local/devcontainer.json, else the CLI's default lookup
_dc_args() {
    local root=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
    reply=(--workspace-folder "$root")
    [[ -f $root/.devcontainer-local/devcontainer.json ]] &&
        reply+=(--config "$root/.devcontainer-local/devcontainer.json")
}
# run a command in it (default: the user's login shell, zsh with these dotfiles)
dce() {
    _dc_args
    (( $# )) || set -- sh -c 'exec "$(getent passwd "$(id -un)" | cut -d: -f7)" -l'
    # exec doesn't pass the terminal type; containers don't know xterm-ghostty
    local term=$TERM
    [[ $term == xterm-ghostty ]] && term=xterm-256color
    devcontainer exec "${reply[@]}" --remote-env TERM=$term --remote-env COLORTERM=$COLORTERM "$@"
}
# rebuild it (new container from the current Dockerfile), with these dotfiles
# set up by scripts/devcontainer.sh (cloned from GitHub, so only pushed changes)
dcb() {
    _dc_args
    devcontainer up "${reply[@]}" --remove-existing-container \
        --dotfiles-repository https://github.com/mintelm/dotfiles \
        --dotfiles-target-path '~/mintelm/dotfiles' \
        --dotfiles-install-command scripts/devcontainer.sh "$@"
}
