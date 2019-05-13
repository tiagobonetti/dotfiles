QT_LIB=($HOME/Qt/5.<->.<->/gcc_64([-1]))
QT_BIN=$QT_LIB/bin
if [ -d $QT_BIN ]; then
    export CMAKE_PREFIX_PATH="$QT_LIB:$CMAKE_PREFIX_PATH"
    export PATH="$QT_BIN:$PATH"
fi
