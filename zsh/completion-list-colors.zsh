# http://zsh.sourceforge.net/Doc/Release/Zsh-Modules.html#The-zsh_002fcomplist-Module
# https://askubuntu.com/questions/17299/what-do-the-different-colors-mean-in-ls
zstyle ':completion:*' list-colors 'di=34;01:ln=36:so=32:pi=33:ex=33;01:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

autoload -Uz compinit && compinit
