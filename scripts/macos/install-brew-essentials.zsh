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
  "llvm"
  "neovim"        # Better vim
  "ninja"
  "romkatv/powerlevel10k/powerlevel10k"
  "python@3.10"
  "ripgrep"       # Better grep
  "tre-command"   # Better tree
)

casks=(
  "gitkraken"
  "iterm2"
  "jetbrains-toolbox"
  "monitorcontrol"           # Control external display settings
  "mos"                      # Better mouse scrooling
  "visual-studio-code"
  #
  # "alfred"                 # better launcher
  # "elmedia-player"         # Media player
  # "forklift mactex-no-gui" # File manager
  # "handbrake"              # Video transcode
  # "steermouse"             # Customize mouse buttons
)

echo "formulae:" ${formulae[@]}
brew install ${formulae[@]}

echo "casks:   " ${casks[@]}
brew install --casks  ${casks[@]}

