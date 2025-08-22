case "$OSTYPE" in
  darwin*)
    # Adds homebrew paths to env
    eval "$(/opt/homebrew/bin/brew shellenv)"

    # Adds .local/bin
    export PATH="$HOME/.local/bin:$PATH"

    # Add the main Python virtual environment to the path
    export PATH="$HOME/.venv/bin:$PATH:"

    # Adds lld to path (some libraries need it available)
    export PATH="$PATH:/opt/homebrew/opt/lld@20/bin"
  ;;
  linux*)
     path+=("$HOME/.local/bin")
     export PATH
  ;;
esac



