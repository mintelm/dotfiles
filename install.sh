#!/bin/bash

# GETOPTS
# reset in case getopts has been used previously in shell
OPTIND=1
force=''
while getopts "f" opt; do
        case "$opt" in
                f) force='f'
                   ;;
        esac
done

# create dirs
if ! [ -z ${force} ]; then
        echo Creating requires directories...
        mkdir -p ~/.cache
        mkdir -p ~/.zsh
        mkdir -p ~/.vim/autoload
        mkdir -p ~/.config/nvim
        mkdir -p ~/.config/bat
        mkdir -p ~/.config/kitty
fi

# zsh stuff
echo Linking zsh stuff...
ln -sv$force $PWD/zsh/zshrc ~/.zshrc
ln -sv$force $PWD/zsh/manydots-magic ~/.zsh
ln -sv$force $PWD/zsh/*.*sh ~/.zsh

# nvim stuff
echo Linking nvim stuff...
ln -sv$force $PWD/nvim/* ~/.config/nvim

# cli tools
echo Linking cli stuff...
ln -sv$force $PWD/cli/tmux.conf ~/.config/tmux.conf
ln -sv$force $PWD/cli/screenrc ~/.config/screenrc
ln -sv$force $PWD/cli/gitconfig ~/.gitconfig
ln -sv$force $PWD/cli/tigrc ~/.config/tigrc
ln -sv$force $PWD/cli/batconfig ~/.config/bat/config

# utils
echo Linking utils stuff...
ln -sv$force $PWD/utils/kitty.conf ~/.config/kitty/kitty.conf
ln -sv$force $PWD/utils/alacritty.yml ~/.config/alacritty.yml
ln -sv$force $PWD/utils/dunstrc ~/.config/dunstrc
ln -sv$force $PWD/utils/Xresources ~/.Xresources
