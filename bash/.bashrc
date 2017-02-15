#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Shell settings
export LANG=en_US.UTF-8
export TERM=xterm-256color
export PS1='[\u@\h \W]\$ '

# Command aliases
alias ls='ls --color=auto'
alias ll='ls -la'

# Arch specific
if [ -f "/etc/arch-release" ]; then
  alias yao='yaourt --noconfirm'
  alias pac='sudo pacman'
fi

# Check for gopath
if [ ! -d "${HOME}/devel/gopath" ]; then
  # gopath does not exist
  mkdir -p "${HOME}/devel/gopath/{bin,src,pkg}"
fi
export GOPATH="${HOME}/devel/gopath"

# Install nvm
export NVM_DIR="/home/oasf/.nvm"
[ -s "${NVM_DIR}/nvm.sh" ] && . "${NVM_DIR}/nvm.sh"

# Update path variable
export PATH="${PATH}:${GOPATH}/bin"
