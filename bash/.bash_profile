#!/usr/bin/env bash
if [[ -e "${HOME}/.bashrc" ]]; then
	source "${HOME}/.bashrc"
fi


# OPAM configuration
. ${HOME}/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
