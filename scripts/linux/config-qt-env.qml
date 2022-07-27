#!/usr/bin/env bash
set -e

INSTALL_PATH="/opt/Qt"
QT_VERSION=5.13.2
QT_LIB=$INSTALL_PATH/$QT_VERSION/gcc_64
QT_BIN=$QT_LIB/bin

if [ ! -d $QT_BIN ]; then
   echo "Qt $QT_VERSION not found in '$INSTALL_PATH'"
   exit
fi

VARS="QT_PLUGIN_PATH\|QT_QPA_PLATFORM_PLUGIN_PATH\|QML2_IMPORT_PATH\|CMAKE_PREFIX_PATH"
if grep -q "$VARS" /etc/environment; then
   echo "Previous QT variables found in '/etc/environment':"
   cat /etc/environment
   exit
fi

sudo tee -a /etc/environment > /dev/null <<EOT
QT_PLUGIN_PATH=$QT_LIB/plugins
QT_QPA_PLATFORM_PLUGIN_PATH=$QT_LIB/plugins/platforms
QML2_IMPORT_PATH=$QT_LIB/qml
CMAKE_PREFIX_PATH=$QT_LIB
EOT

