#!/usr/bin/env bash
diff -Naur ~/.zshrc.backup ../.zshrc > zshrc.patch
diff -Naur ~/.oh-my-zsh/themes/agnoster.zsh-theme ../zsh-custom/agnoster-custom.zsh-theme > agnoster.zsh-theme.patch

