arduino_sdk=$(echo $HOME/arduino-<->.<->.<->([-1]))
if [ -d $arduino_sdk ]; then
    export ARDUINO_SDK_PATH="$arduino_sdk"

    arduino_makefile=$HOME/Arduino-Makefile
    if [ -d $arduino_makefile ]; then
        export ARDUINO_DIR="$arduino_sdk"
        export ARDMK_DIR="$arduino_makefile"
    fi
fi

nvim-arduino() { find "$@" \( -name "*.cpp" -o -name "*.ino" -o -name "*.h" \) -printf '%f\t%p\n' | sort | cut -f 2 | xargs -r nvim }
