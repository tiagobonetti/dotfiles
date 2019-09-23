#!/usr/bin/env bash
pkgs=(
    conan
    pytest
    git+https://github.com/onnodb/qtsass.git # for building some qt applications
)
set -e
pip3 install ${pkgs[@]}
