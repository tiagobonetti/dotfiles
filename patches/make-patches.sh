#!/usr/bin/env bash
DIR="$(dirname $(readlink -f $0))"
diff -Naur ~/.zshrc.backup $DIR/../.zshrc > $DIR/zshrc.patch
diff -Naur ~/.oh-my-zsh/themes/agnoster.zsh-theme $DIR/../zsh-custom/agnoster-custom.zsh-theme > $DIR/agnoster.zsh-theme.patch

