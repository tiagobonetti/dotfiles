#!/usr/bin/env bash
function link() {
    filename= $1
    folder= $2

    # skip files already linked
    if [[ -L $2/$1 && $(readlink -f $2/$1) == $(readlink -f $1) ]]
    then
        echo "\"$2/$1\" already linked: skipping"
        return 0
    fi

    # backup any real file
    if [[ -f $2/$1 ]]
    then
        echo "\"$2/$1\" exists: moving it to \"$2/$1.backup\""
        mv $2/$1 $2/$1.backup
    fi

    # link to dotfiles
    ln -s $(readlink -f $1) $2/$1
    echo "Linked: \"$2/$1\" -> \"$1\""
}

link .zshrc ~
link .ideavimrc ~

mkdir -p ~/.config/nvim
link init.vim ~/.config/nvim
