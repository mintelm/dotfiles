#!/bin/bash

usage() {
    printf "Usage: $0 [-f] [-b] \n\nOptions:\n    -f: force link; also creates dirs\n    -b: build maple font\n";
    exit 1;
}

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# reset in case getopts has been used previously in shell
OPTIND=1
while getopts "fbh" opt; do
    case "$opt" in
        f)
            f='f'
            echo "Creating required directories"
            mkdir -p ~/.cache ~/.zsh ~/.config/nvim ~/.config/bat ~/.config/clangd
            ;;
        b)
            build=1
            echo "Building maple font"
            mkdir build
            ;;
        h)
            ;&
        *)
            usage
            ;;
    esac
done

# zsh stuff
echo "Linking zsh stuff"
ln -sv$f $SCRIPT_DIR/config/zsh/zshrc ~/.zshrc
ln -sv$f $SCRIPT_DIR/config/zsh/zshenv ~/.zshenv
ln -sv$f $SCRIPT_DIR/config/zsh/manydots-magic ~/.zsh
ln -sv$f $SCRIPT_DIR/config/zsh/*.*sh ~/.zsh

# nvim stuff
echo "Linking nvim stuff"
ln -sv$f $SCRIPT_DIR/config/nvim/* ~/.config/nvim

# cli tools
echo "Linking cli stuff"
ln -sv$f $SCRIPT_DIR/config/tmux/tmux.conf ~/.config/tmux.conf
ln -sv$f $SCRIPT_DIR/config/git/config ~/.gitconfig
ln -sv$f $SCRIPT_DIR/config/tig/config ~/.tigrc
ln -sv$f $SCRIPT_DIR/config/bat/config ~/.config/bat/config
ln -sv$f $SCRIPT_DIR/config/clangd/config.yaml ~/.config/clangd/config.yaml



# build font
if [[ -v build ]]; then
    if command -v fontforge &> /dev/null; then
        echo "Building maple font"
        pushd build
        git clone https://github.com/subframe7536/maple-font --depth 1 -b variable
        pushd maple-font
        python -m venv venv
        cp $SCRIPT_DIR/maple_font.json config.json
        source venv/bin/activate
        pip install -r requirements.txt
        python build.py --no-liga --no-hinted
        dirs -c
        deactivate
    else
        echo "Can not build fonts since package 'fontforge' is not installed!"
    fi
fi
