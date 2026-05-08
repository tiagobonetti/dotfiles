# Aliases
alias l='ls -gAFGh'
alias gitk='gitk --max-count=500'

# avoid unecesary corrections (usually to paths) on this commands
alias git='nocorrect git'
alias vim='nocorrect vim'
alias ssh='nocorrect ssh'

nvim-cpp() { find "$@" \( -name "*.cpp" -o -name "*.h" -o -name "*.hpp" \) -printf '%f\t%p\n' | sort | cut -f 2 | xargs -r nvim }
nvim-cmake() { find "$@" -name "CMakeLists.txt" | xargs -r nvim}
nvim-files() { find "$@" -type f -printf '%f\t%p\n' | sort | cut -f 2 | xargs -r nvim }
nvim-diff() { git diff --name-only | uniq | xargs -r nvim }

alias svim='vim -u ~/SpaceVim/vimrc'

# LazyVim - side-by-side Neovim distribution
# Uses separate config in ~/.config/nvim-lazy
alias lvim='NVIM_APPNAME=nvim-lazy nvim'
alias nvim-lazy='NVIM_APPNAME=nvim-lazy nvim'

# LazyVim helper functions (mirror of nvim-* functions)
lvim-cpp() { find "$@" \( -name "*.cpp" -o -name "*.h" -o -name "*.hpp" \) -printf '%f\t%p\n' | sort | cut -f 2 | xargs -r env NVIM_APPNAME=nvim-lazy nvim }
lvim-cmake() { find "$@" -name "CMakeLists.txt" | xargs -r env NVIM_APPNAME=nvim-lazy nvim }
lvim-files() { find "$@" -type f -printf '%f\t%p\n' | sort | cut -f 2 | xargs -r env NVIM_APPNAME=nvim-lazy nvim }
lvim-diff() { git diff --name-only | uniq | xargs -r env NVIM_APPNAME=nvim-lazy nvim }

case "$OSTYPE" in
  linux*)
    # More ergonomical access to fd on ubuntu
    alias fd='fdfind'
  ;;
esac


