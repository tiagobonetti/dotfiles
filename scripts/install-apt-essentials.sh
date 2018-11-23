#!/usr/bin/env bash
pkgs=(
    build-essential
    ccache
    clang
    clang-format
    cmake
    curl
    exuberant-ctags
    git-gui
    git-lfs
    gitk
    graphviz
    htop
    neovim
    ninja-build
    python-dev
    python-pip
    python3-dev
    python3-pip
    silversearcher-ag
    tree
    zsh
)
set -e
sudo apt update
sudo apt install ${pkgs[@]}
sudo apt autoremove

