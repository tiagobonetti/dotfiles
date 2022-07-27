#!/usr/bin/env bash
set -e
pkg=slack-desktop-4.0.2-amd64.deb
wget https://downloads.slack-edge.com/linux_releases/$pkg -O /tmp/$pkg
sudo apt install /tmp/$pkg
