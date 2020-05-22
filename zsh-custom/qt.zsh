QT_LIB=(/opt/Qt/5.<->.<->/gcc_64([-1]N))
QT_BIN=$QT_LIB/bin

if [ -d $QT_BIN ]; then
    export PATH="$QT_BIN:$PATH"
fi

