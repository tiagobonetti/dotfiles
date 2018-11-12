# Bluelake helper aliases and functions
alias conda-bluelake-build='conda activate bluelake-build'
alias cmake-bluelake-release-debug='CC=clang CXX=clang++ cmake -G Ninja -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_EXPORT_COMPILE_COMMANDS=ON'
alias cmake-clang-ninja='CC=clang CXX=clang++ cmake -G Ninja -DCMAKE_EXPORT_COMPILE_COMMANDS=ON'

nvim-cpp() { find $1 -name "*.cpp" -o -name "*.h" | xargs nvim }
nvim-cmake() { find $1 -name "CMakeLists.txt" | xargs nvim}
nvim-files() { find $1 -type f | xargs nvim }

