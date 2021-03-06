#!/usr/bin/env bash
CFG=$HOME/dotfiles/tilix.dconf

if [ "$1" == "--save" ]; then
    dconf dump /com/gexperts/Tilix/ > $CFG
else
    dconf load /com/gexperts/Tilix/ < $CFG
fi

echo "Select your preferred terminal application"
sudo update-alternatives --config x-terminal-emulator
