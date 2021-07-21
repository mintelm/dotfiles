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

set -x
# create dirs
if ! [ -z ${force} ]; then
        mkdir -p ~/.cache
        mkdir -p ~/.zsh
        mkdir -p ~/.xmonad
        mkdir -p ~/.vim/autoload
        mkdir -p ~/.config/nvim
        mkdir -p ~/.config/rofi
        mkdir -p ~/.config/bat
        mkdir -p ~/.config/kitty
        mkdir -p ~/.config/oomox/colors/
fi

# zsh stuff
ln -sv$force $PWD/zsh/zshrc ~/.zshrc
ln -sv$force $PWD/zsh/manydots-magic ~/.zsh
ln -sv$force $PWD/zsh/*.*sh ~/.zsh/

# xmonad
ln -sv$force $PWD/xmonad/* ~/.xmonad/

# vim stuff
# ln -sv$force $PWD/vim/vimrc ~/.vimrc
# ln -sv$force $PWD/vim/init.vim ~/.config/nvim/init.vim
# ln -sv$force $PWD/vim/autoload/* ~/.vim/autoload/
# ln -sv$force $PWD/vim/coc-settings.json ~/.vim/coc-settings.json
# ln -sv$force $PWD/vim/coc-settings.json ~/.config/nvim/coc-settings.json
ln -sv$force $PWD/nvim/* ~/.config/nvim/

# cli tools
ln -sv$force $PWD/cli/tmux.conf ~/.config/tmux.conf
ln -sv$force $PWD/cli/screenrc ~/.config/screenrc
ln -sv$force $PWD/cli/gitconfig ~/.gitconfig
ln -sv$force $PWD/cli/tigrc ~/.config/tigrc
ln -sv$force $PWD/cli/batconfig ~/.config/bat/config

# utils
ln -sv$force $PWD/utils/kitty.conf ~/.config/kitty/kitty.conf
ln -sv$force $PWD/utils/alacritty.yml ~/.config/alacritty.yml
ln -sv$force $PWD/utils/dunstrc ~/.config/dunstrc
ln -sv$force $PWD/utils/picom.conf ~/.config/picom.conf
ln -sv$force $PWD/utils/Xresources ~/.Xresources

# themes
ln -sv$force $PWD/themes/rofi/* ~/.config/rofi/
ln -sv$force $PWD/themes/oomox/* ~/.config/oomox/colors/
