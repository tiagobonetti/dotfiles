#!/usr/bin/env bash
basename=arduino-1.8.10
filename=$basename-linux64.tar.xz
url=https://downloads.arduino.cc/$filename
pkg=/tmp/$filename

echo "Download installer: '$pkg'"
wget $url -O $pkg
echo "Installing: extracting to '$HOME/$basename'"
tar -C $HOME -xvf $pkg
echo "Installing: creating links"
sh $HOME/$basename/install.sh
echo "Adding $USER to the dialout group"
sudo adduser $USER dialout
echo "Done"
