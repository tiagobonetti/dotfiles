QT_LIB=(/opt/Qt/5.<->.<->/gcc_64([-1]N))
QT_BIN=$QT_LIB/bin

if [ -d $QT_BIN ]; then
    export PATH="$PATH:$QT_BIN"
    export QT_PLUGIN_PATH="$QT_LIB/plugins"
    export QT_QPA_PLATFORM_PLUGIN_PATH="$QT_LIB/plugins/platforms"
    export QML2_IMPORT_PATH="$QT_LIB/qml"
    export CMAKE_PREFIX_PATH="$CMAKE_PREFIX_PATH:$QT_LIB"
fi

