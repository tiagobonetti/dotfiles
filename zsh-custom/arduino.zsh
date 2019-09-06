ARDMK_DIR=$HOME/Arduino-Makefile
if [ -d $ARDMK_DIR ]; then
    export ARDUINO_DIR=$(echo $HOME/arduino-<->.<->.<->([-1]))
    export ARDMK_DIR="$ARDMK_DIR"
fi

nvim-arduino() { find "$@" \( -name "*.cpp" -o -name "*.ino" -o -name "*.h" \) -printf '%f\t%p\n' | sort | cut -f 2 | xargs -r nvim }
