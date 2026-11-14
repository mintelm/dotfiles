zmodload zsh/complist
bindkey '^R' history-incremental-pattern-search-backward # ctrl + r
bindkey -M isearch '^J' history-incremental-search-forward # ctrl + j
bindkey -M isearch '^K' history-incremental-search-backward # ctrl + k
bindkey "^[[3~" delete-char # del
bindkey '^[[Z' reverse-menu-complete # shift + tab
bindkey "^[[1;5C" forward-word # ctrl + <-
bindkey "^[[1;5D" backward-word # ctrl + ->
