# Aliases
alias l='ls -gAFGh'
alias gitk='gitk --max-count=500'

# avoid unecesary corrections (usually to paths) on this commands
alias git='nocorrect git'
alias vim='nocorrect vim'
alias ssh='nocorrect ssh'

alias cmake-clang-ninja='CC=clang CXX=clang++ cmake -G Ninja -DCMAKE_EXPORT_COMPILE_COMMANDS=ON'

nvim-cpp() { find "$@" -name "*.cpp" -o -name "*.h" | xargs nvim }
nvim-cmake() { find "$@" -name "CMakeLists.txt" | xargs nvim}
nvim-files() { find "$@" -type f | xargs nvim }
nvim-conflicts() { git diff --name-only | uniq | xargs nvim }

