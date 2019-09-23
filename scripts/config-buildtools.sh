#!/usr/bin/env bash
sudo update-alternatives --config c++
sudo update-alternatives --config cc
# setup alternatives for the linker
sudo update-alternatives --install "/usr/bin/ld" "ld" "/usr/bin/ld.bfd" 20
sudo update-alternatives --install "/usr/bin/ld" "ld" "/usr/bin/ld.gold" 10
sudo update-alternatives --install "/usr/bin/ld" "ld" "/usr/bin/ld.lld" 10
sudo update-alternatives --config ld
