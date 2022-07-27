#!/usr/bin/env zsh

# Install a more up-to-date zsh
brew install zsh

# Add homebrew zsh to the list of know shells
echo "/opt/homebrew/bin/zsh" | sudo tee -a /etc/shells

# Configure it to be the default for the current user
chsh -s /opt/homebrew/bin/zsh
