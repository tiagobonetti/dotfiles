#!/usr/bin/env bash
url=https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
path=/tmp/teamviewer_amd64.deb
set -e
wget $url -O $path && sudo apt install $path
