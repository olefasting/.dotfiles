#
# ~/.bashrc
#

export LANG=en_US.UTF-8

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

TERM=xterm-256color
