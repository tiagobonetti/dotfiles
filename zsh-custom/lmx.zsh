# helper aliases and functions
alias conda-bluelake-build='conda activate bluelake-build'
alias cmake-bluelake-release-debug='CC=clang CXX=clang++ cmake -G Ninja -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DLMX_FORCE_COLOR_OUTPUT=ON'
alias cmake-bluelake-release-debug-tidy='CC=clang CXX=clang++ cmake -G Ninja -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DLMX_FORCE_COLOR_OUTPUT=ON -DLMX_CLANG_TIDY=ON -DLMX_CLANG_TIDY_EXE=clang-tidy-7'
alias cmake-bluelake-release-debug-iwyu='CC=clang CXX=clang++ cmake -G Ninja -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DLMX_FORCE_COLOR_OUTPUT=ON -DCMAKE_CXX_INCLUDE_WHAT_YOU_USE="/home/tbonetti/lumicks/include-what-you-use/build/bin/include-what-you-use;-Xiwyu;any;-Xiwyu;iwyu;-Xiwyu;args"'

walrus-scene() {
    WALRUS=($HOME/.conan/data/walrus-qml/*/lumicks/stable/package/*/qml/([-1]))
    qmlscene -I "$WALRUS" "$@"
}
