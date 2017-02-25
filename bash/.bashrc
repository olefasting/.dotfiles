#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Environment
source ~/.bashenv

# Command aliases
alias ls='ls --color=auto'
alias ll='ls -la'

# Arch (desktop) specific
if [ -f "/etc/arch-release" ]; then
  alias yao='yaourt --noconfirm'
  alias pac='sudo pacman'
fi

# Check for gopath
if [ ! -d "${GOPATH}" ]; then
  # gopath does not exist
  mkdir -p "${GOPATH}/src"
  mkdir "${GOPATH}/bin"
  mkdir "${GOPATH}/pkg"
fi

# Install nvm
export NVM_DIR="/home/oasf/.nvm"
[ -s "${NVM_DIR}/nvm.sh" ] && . "${NVM_DIR}/nvm.sh"
