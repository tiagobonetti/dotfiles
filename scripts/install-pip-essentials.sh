#!/usr/bin/env bash
pkgs=(
    cmake
    conan
    deprecated
    h5py
    ninja
    numpy
    numpydoc
    pytest
    pyyaml
    # custom packages from git
    git+https://github.com/onnodb/qtsass.git # for building some qt applications
)
pip3 install ${pkgs[@]}
