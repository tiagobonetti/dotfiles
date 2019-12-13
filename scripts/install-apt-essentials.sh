#!/usr/bin/env bash
pkgs=(
    baobab # disk usage analyzer
    build-essential
    ccache
    clang
    clang-format
    clang-tidy
    cmake
    curl
    exuberant-ctags
    #fd-find
    #fonts-noto-color-emoji
    #fzf
    git-gui
    git-lfs
    gitk
    gnome-tweaks
    graphviz
    htop
    intelmkl # for building some applications
    isc-dhcp-server
    libgl1-mesa-dev # for building qt applications
    lld
    neovim
    ninja-build
    python-dev
    python-pip
    python3-dev
    python3-pip
    #ripgrep
    silversearcher-ag
    tilix
    tree
    zsh
)
set -e
sudo apt update
sudo apt install ${pkgs[@]}
sudo apt autoremove

