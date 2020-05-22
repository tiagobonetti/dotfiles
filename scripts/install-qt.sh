#!/usr/bin/env bash
set -e

INSTALL_PATH="/opt/Qt"
QT_VERSION=5.13.2
sudo apt install p7zip-full
pip3 install --user aqtinstall==0.5.2
sudo mkdir $INSTALL_PATH
sudo chown $USER $INSTALL_PATH
aqt install --outputdir $INSTALL_PATH $QT_VERSION linux desktop
