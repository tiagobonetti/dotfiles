RUST_BIN=$HOME/.cargo/bin
if [ -d $RUST_BIN ]; then
    export PATH="$RUST_BIN:$PATH"
fi
