#!/usr/bin/env bash
PLUG_PATH=$HOME/.local/share/nvim/site/autoload/plug.vim
if [ -f $PLUG_PATH ]; then
    echo "Vim-plug already installed"
else
    echo "Intalling vim-plug"
    curl -fLo $PLUG_PATH --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

