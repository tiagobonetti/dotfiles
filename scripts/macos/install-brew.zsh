#!/usr/bin/env zsh

# Maybe check the website to see if the script has changed!
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Adds environment variables into the current user profile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile

# Inlines environment variables here so we can continue working form here
eval "$(/opt/homebrew/bin/brew shellenv)"

