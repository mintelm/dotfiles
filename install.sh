#!/bin/bash

usage() {
        printf "Usage: $0 [-f] \n\nOptions:\n    -f: force link; also creates dirs\n";
        exit 1;
}

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# reset in case getopts has been used previously in shell
OPTIND=1
while getopts "f" opt; do
        case "$opt" in
                f)
                        f='f'
                        echo Creating required directories...
                        mkdir -p ~/.cache ~/.zsh ~/.config/nvim ~/.config/bat ~/.config/kitty ~/.local/bin
                        ;;
                *)
                        usage
        esac
done

# zsh stuff
echo Linking zsh stuff...
ln -sv$f $SCRIPT_DIR/zsh/zshrc ~/.zshrc
ln -sv$f $SCRIPT_DIR/zsh/zshenv ~/.zshenv
ln -sv$f $SCRIPT_DIR/zsh/manydots-magic ~/.zsh
ln -sv$f $SCRIPT_DIR/zsh/*.*sh ~/.zsh

# nvim stuff
echo Linking nvim stuff...
ln -sv$f $SCRIPT_DIR/nvim/* ~/.config/nvim

# cli tools
echo Linking cli stuff...
ln -sv$f $SCRIPT_DIR/cli/tmux.conf ~/.config/tmux.conf
ln -sv$f $SCRIPT_DIR/cli/screenrc ~/.config/screenrc
ln -sv$f $SCRIPT_DIR/cli/gitconfig ~/.gitconfig
ln -sv$f $SCRIPT_DIR/cli/tigrc ~/.tigrc
ln -sv$f $SCRIPT_DIR/cli/batconfig ~/.config/bat/config
ln -sv$f $SCRIPT_DIR/cli/Xresources ~/.Xresources

# utils
echo Linking utils stuff...
ln -sv$f $SCRIPT_DIR/utils/kitty.conf ~/.config/kitty/kitty.conf
ln -sv$f $SCRIPT_DIR/utils/alacritty.yml ~/.config/alacritty.yml
ln -sv$f $SCRIPT_DIR/utils/dunstrc ~/.config/dunstrc

# shellscripts
echo Linking shell scripts...
ln -sv$f $SCRIPT_DIR/shellscripts/* ~/.local/bin
