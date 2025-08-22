#!/usr/bin/env zsh

formulae=(
  "autojump"      # Quick way to jump to folders in terminal
  "bat"           # Better cat
  "ccache"
  "cloc"          # Count lines of code
  "cmake"
  "fd"            # Better find
  "fzf"           # Command line fuzzy finder
  "gh"            # GitHub CLI
  "git"
  "git-lfs"
  "ipython"
  "llvm"
  "neovim"        # Better vim
  "ninja"
  "python@3.12"
  "ripgrep"       # Better grep
  "tre-command"   # Better tree
)

casks=(
  "fork"
  "google-chrome"
  "handbrake-app"            # Video conversion tool
  "iterm2"
  "jetbrains-toolbox"
  "monitorcontrol"           # Control external display settings
  "mos"                      # Better mouse scrooling
  "slack"
  "stats"                    # show system stats
  "vlc"
  # "alfred"                 # better launcher
  # "forklift mactex-no-gui" # File manager
  # "steermouse"             # Customize mouse buttons
  # "visual-studio-code"
)

echo "formulae:" ${formulae[@]}
brew install ${formulae[@]}

echo "casks:   " ${casks[@]}
brew install --casks  ${casks[@]}

