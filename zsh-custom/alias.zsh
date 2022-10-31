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

case "$OSTYPE" in
  linux*)
    # More ergonomical access to fd on ubuntu
    alias fd='fdfind'
  ;;
esac


