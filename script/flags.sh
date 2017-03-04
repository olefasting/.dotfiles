#!/usr/bin/env bash

parse_flags() {
    local flags=()

    # Defaults
    [[ -z "${NO_PKG_UPGRADES}" ]] && NO_PKG_UPGRADES='true'

    # Parse
    if [[ "${DO_REINSTALL}" == 'true' ]]; then
        flags=("${flags[@]}" "'DO_REINSTALL':      Initial setup will install some extras")
    fi

    if [[ "${NO_PKG_UPGRADES}" == 'true' ]]; then
        flags=("${flags[@]}" "'NO_PKG_UPGRADES':    Don't upgrade installed dependencies")
    fi

    if [[ "${SERVER}" == 'true' ]]; then
        flags=("${flags[@]}" "'SERVER':             Only server files will be installed")

        NO_XORG='true'
    fi

    if [[ "${NO_XORG}" == 'true' ]]; then
        flags=("${flags[@]}" "'NO_XORG':            Xorg will not be installed")
    fi

    if [[ "${#flags[@]}" > "0" ]]; then
        local i=0
        local cnt="${#flags[@]}"

        while [[ "${i}" < "${cnt}" ]]; do
            echo "${flags["${i}"]}" >&2

            let "i+=1"
        done        
    fi
}