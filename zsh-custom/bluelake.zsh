# Bluelake helper aliases and functions
alias conda-bluelake-build='conda activate bluelake-build'
alias cmake-bluelake-release-debug='CC=clang CXX=clang++ cmake -G Ninja -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_EXPORT_COMPILE_COMMANDS=ON'
alias cmake-bluelake-release-debug-tidy='CC=clang CXX=clang++ cmake -G Ninja -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DLMX_CLANG_TIDY=ON -DLMX_CLANG_TIDY_EXE=clang-tidy-7'

