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



export NVM_DIR="/home/oasf/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
