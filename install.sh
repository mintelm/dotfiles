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
	mkdir -p ~/.cache
	mkdir -p ~/.vim/autoload
	mkdir -p ~/.config/nvim
	mkdir -p ~/.config/rofi
	mkdir -p ~/.config/oomox/colors/
fi

# vim stuff
ln -sv$force $PWD/vim/vimrc ~/.vimrc
ln -sv$force $PWD/vim/init.vim ~/.config/nvim/init.vim
ln -sv$force $PWD/vim/autoload/* ~/.vim/autoload/
ln -sv$force $PWD/vim/coc-settings.json ~/.vim/coc-settings.json
ln -sv$force $PWD/vim/coc-settings.json ~/.config/nvim/coc-settings.json

# cli tools
ln -sv$force $PWD/zshrc ~/.zshrc
ln -sv$force $PWD/tmux.conf ~/.tmux.conf
ln -sv$force $PWD/screenrc ~/.screenrc
ln -sv$force $PWD/gitconfig ~/.gitconfig
ln -sv$force $PWD/tigrc ~/.tigrc

# others
ln -sv$force $PWD/alacritty.yml ~/.config/alacritty.yml
ln -sv$force $PWD/picom.conf ~/.config/picom.conf
ln -sv$force $PWD/themes/rofi/* ~/.config/rofi/
ln -sv$force $PWD/themes/oomox/* ~/.config/oomox/colors/
