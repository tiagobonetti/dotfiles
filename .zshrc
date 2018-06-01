# profiling pre
#zmodload zsh/zprof

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
plugins=(git colored-man colorize cp python gnu-utils zsh-syntax-highlighting ubuntu ag)
#plugins+=(zsh-nvm)
# slow modules: zsh-nvm

# User configuration
setopt NO_SHARE_HISTORY

# source
source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG_ALL=en_US.UTF-8
export LANGUAGE=en_US:en

# Aliases
alias l='ls -gAFGh'
alias gitk='gitk --max-count=500'

alias one-ssh='sshpass -p be ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o User=root'
alias one-scp='sshpass -p be scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o User=root'

alias git='nocorrect git'
alias vim='nocorrect vim'
alias ssh='nocorrect ssh'
alias sshpass='nocorrect sshpass'

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
    source /etc/profile.d/vte.sh
fi

loadplugins () {
    plugin=$1 

    if is_plugin $ZSH_CUSTOM $plugin
    then
            fpath=($ZSH_CUSTOM/plugins/$plugin $fpath) 
    elif is_plugin $ZSH $plugin
    then
            fpath=($ZSH/plugins/$plugin $fpath) 
    fi
    if [ -f $ZSH_CUSTOM/plugins/$plugin/$plugin.plugin.zsh ]
    then
            source $ZSH_CUSTOM/plugins/$plugin/$plugin.plugin.zsh
    elif [ -f $ZSH/plugins/$plugin/$plugin.plugin.zsh ]
    then
            source $ZSH/plugins/$plugin/$plugin.plugin.zsh
    fi
}

# profiling post
#zprof
