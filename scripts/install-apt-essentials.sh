#!/usr/bin/env bash
pkgs=(
    neovim
    zsh
    curl
    exuberant-ctags
    silversearcher-ag
    build-essential
    cmake
    gitk
    git-gui
    git-lfs
    python-dev
    python-pip
    python3-dev
    python3-pip
    tree
    htop
    clang
    clang-format
)
set -e
sudo apt update
sudo apt install ${pkgs[@]}
sudo apt autoremove

