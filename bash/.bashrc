#
# ~/.bashrc
#

export LANG=en_US.UTF-8

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


alias ls='ls --color=auto'
alias ll='ls -la'
PS1='[\u@\h \W]\$ '

TERM=xterm-256color

[ -z "$NVM_DIR" ] && export NVM_DIR="$HOME/.nvm"
source /usr/share/nvm/nvm.sh
source /usr/share/nvm/bash_completion
source /usr/share/nvm/install-nvm-exec
