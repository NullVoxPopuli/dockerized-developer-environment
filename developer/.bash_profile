# Load the Ruby Loader and auto-switcher
source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh

# This loads the node-version-manager
[[ -s "$HOME/.nvm/nvm.sh" ]] && source "$HOME/.nvm/nvm.sh"
# allows git usage in PS1
source "$HOME/scripts/bash-support/git-prompt.sh"
# Extend our path, include scripts, etc
source "$HOME/scripts/bash-support/paths.sh"
# allows having the current command running as the title of your terminal window
source "$HOME/scripts/bash-support/current-command.sh"
# custom PS1, configure by commenting out PS1= lines
source "$HOME/scripts/bash-support/ps1.sh"

export NVM_DIR="$HOME/.nvm"
export NODE_PATH="$HOME/.npm/lib/node_modules:$NODE_PATH"


# handy aliases
# shopt -s direxpand
shopt -s expand_aliases


eval `dircolors -b`
alias ls='ls --color=auto -h'
alias dir='ls --color=auto --format=vertical -h'
alias vdir='ls --color=auto --format=long -h'
alias ll="ls -lh"
alias la="ls -lah"
alias ng="nuke-gently"

# Git
alias gc='git checkout'
alias gs='git status'
alias gl='git log'
alias gd='git diff'
alias gbs='git branch-status'
alias gb='git branch'
alias gls='git log --pretty=format:"%C(yellow)%h\\ %ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --date=relative'
alias gia='git add --patch'
alias herpderp='ember'

# Ruby
alias be='bundle exec'

# tab completion
if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

# colors!
if [ -e /usr/share/terminfo/x/xterm-256color ]; then
  export TERM='xterm-256color'
else
  export TERM='xterm-color'
fi


# http://unix.stackexchange.com/questions/72086/ctrl-s-hang-terminal-emulator
# Prevents Ctrl+s and Ctrl+q from haulting vim sessions
stty -ixon
