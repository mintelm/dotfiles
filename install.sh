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

# standard
ln -sv$force $PWD/zshrc ~/.zshrc
ln -sv$force $PWD/vimrc ~/.vimrc
ln -sv$force $PWD/alacritty.yml ~/.config/alacritty.yml
ln -sv$force $PWD/tmux.conf ~/.tmux.conf
ln -sv$force $PWD/screenrc ~/.screenrc
ln -sv$force $PWD/gitconfig ~/.gitconfig
ln -sv$force $PWD/compton.conf ~/.config/compton.conf
ln -sv$force $PWD/themes/rofi/* ~/.config/rofi/

# nvim
if [[ -d ~/.config/nvim ]]; then
        ln -sv$force $PWD/init.vim ~/.config/nvim/init.vim
        ln -sv$force $PWD/coc-settings.json ~/.config/nvim/coc-settings.json
fi

# awesome
ln -sv$force $PWD/awesome ~/.config/
