case "$OSTYPE" in
  darwin*)
    # Adds homebrew paths to env
    eval "$(/opt/homebrew/bin/brew shellenv)"

    # Adds clang@18 to path
    export PATH="/opt/homebrew/opt/llvm@18/bin:$PATH"

    # Adds python@3.12 to path
    export PATH="/opt/homebrew/opt/python@3.12/bin:$PATH"
    export PATH="/opt/homebrew/opt/python@3.12/libexec/bin:$PATH"

    # Adds .local/bin
    export PATH="$HOME/.local/bin:$PATH"

    # For compiling with brew's LLVM on MACOS
    export MACOSX_DEPLOYMENT_TARGET=14.5
  ;;
  linux*)
     path+=("$HOME/.local/bin")
     export PATH
  ;;
esac



