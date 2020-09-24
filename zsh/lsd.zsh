lsd() {
    if [ -z "$1" ]; then
        cdr -l
    else
        if [ "$1" ]; then
            cdr $1
        fi
    fi
}

zstyle ':chpwd:*' recent-dirs-max 9
zstyle ':chpwd:*' recent-dirs-prune parent

autoload -Uz chpwd_recent_dirs cdr
autoload -Uz add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
