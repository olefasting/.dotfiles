#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# check for gopath
if [ ! -d "~/devel/go" ]; then
  # gopath does not exist
  mkdir -p ~/devel/go/{bin,src}
fi
export GOPATH=~/devel/go
export PATH=$PATH:$GOPATH
