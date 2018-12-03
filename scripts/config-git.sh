#!/usr/bin/env bash
git config --global user.email "tiago.bonetti@gmail.com"
git config --global user.name "Tiago Bonetti"
git config --global diff.tool vimdiff
git config --global difftool.vimdiff.path nvim
git config --global merge.tool vimdiff
git config --global mergetool.vimdiff.path nvim
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status
