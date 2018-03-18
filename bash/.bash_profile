#!/usr/bin/env bash
if [[ -e .bashrc ]]; then
	source .bashrc
fi

export PATH="$HOME/.cargo/bin:$PATH"
