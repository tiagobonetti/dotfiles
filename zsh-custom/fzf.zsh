export FZF_DEFAULT_COMMAND='fdfind --type file --color=always'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--ansi'

alias fzf-commit="git log --pretty=oneline --abbrev-commit --color=always | fzf --preview 'git show {+1} --name-only --color=always' | cut -d' ' -f1"
