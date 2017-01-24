#!/usr/bin/env bash
ABS_PATH="${BASH_SOURCE[0]}"
if [ -h "${ABS_PATH}" ]; then
  while [ -h "${ABS_PATH}" ]; do
    ABS_PATH=`readlink "${ABS_PATH}"`
  done
fi
pushd . > /dev/null
cd `dirname ${ABS_PATH}` > /dev/null
ABS_PATH=`pwd`;
popd  > /dev/null

# Make symlinks
echo "Creating symlinks"

ln -s "${ABS_PATH}/bash/.bashrc" "${HOME}/.bashrc"
ln -s "${ABS_PATH}/bash/.bash_profile" "${HOME}/.bash_profile"
ln -s "${ABS_PATH}/bash/.bash_logout" "${HOME}/.bash_logout"
ln -s "${ABS_PATH}/tmux/.tmux.conf" "${HOME}/.tmux.conf"
ln -s "${ABS_PATH}/vim/.vimrc" "${HOME}/.vimrc"

# Done!
echo "All done."
