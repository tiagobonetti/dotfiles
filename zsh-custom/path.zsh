case "$OSTYPE" in
  darwin*)
    # Adds homebrew paths to env
    eval "$(/opt/homebrew/bin/brew shellenv)"

    # Adds python@3.10 to path
    export PATH="/opt/homebrew/opt/python@3.10/bin:$PATH"
    export PATH="/opt/homebrew/opt/python@3.10/libexec/bin:$PATH"

    # For compiling with brew's LLVM on MACOS
    export LDFLAGS="--ld-path=/opt/homebrew/opt/llvm/bin/ld64.lld"
    export MACOSX_DEPLOYMENT_TARGET=12.0
  ;;
  linux*)
     path+=("$HOME/.local/bin")
     export PATH
  ;;
esac


