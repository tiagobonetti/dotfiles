# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
ZSH_THEME="bonetti"

export DEFAULT_USER="tiagobonetti"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(git colored-man colorize cp python gnu-utils zsh-syntax-highlighting ubuntu ag )
plugins+=(zsh-nvm)

# User configuration
setopt NO_SHARE_HISTORY

# source
source $ZSH/custom/notify-osd.zsh
source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG_ALL=en_US.UTF-8
export LANGUAGE=en_US:en

# Aliases
alias l='ls -gAFGh'
alias gitk='gitk --max-count=500'
alias vless='/usr/share/vim/vim*/macros/less.sh'
lgrep () { grep --color=always $* | less -R  }

alias one-ssh='sshpass -p be ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o User=root'
alias one-scp='sshpass -p be scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o User=root'


alias git='nocorrect git'
alias vim='nocorrect vim'
alias ssh='nocorrect ssh'
alias sshpass='nocorrect sshpass'

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi
