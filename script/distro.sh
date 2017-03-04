#!/usr/bin/env bash

DISTRO=""

DISTRO_ARCH="arch"
DISTRO_UBUNTU="ubuntu"
DISTRO_DEBIAN="debian"

DISTRO_LIST=("${DISTRO_ARCH}" "${DISTRO_UBUNTU}" "${DISTRO_DEBIAN}")

DISTRO_UNKNOWN='unknown'

determine_distro() {
    if [[ ! -z "${DISTRO}" ]]; then
        local i = 0
        local cnt = "${#DISTRO_LIST[@]}"

        while [[ "${i}" < "${cnt}" ]]; do
            if [[ "${DISTRO}" == "${DISTRO_LIST[${i}]}" ]]; then
                # Manually set distro found
                echo `"Environment variable 'DISTRO' was set, and the specified distro '${DISTRO}' has been selected."`

                # Break loop by setting i to cnt
                let "i=${cnt}"
            elif [[ "${i}" == "${cnt}-1" ]]; then
                # Last item and no match was found.
                echo `"Environment variable 'DISTRO' was set, but the specified distro '${DISTRO}' is not supported.
                Trying auto detect in stead."`
                
                # Set to blank and try next step.
                DISTRO=""
            else
                let "i+=1"
            fi
        done
    fi

    if [[ -z "${DISTRO}" ]]; then
        if [ -f "/etc/os-release" ]; then
            DISTRO="$(get_distro_name)"
        else
            DISTRO="${DISTRO_UNKNOWN}"
            
        fi
    fi
}

get_distro_name() (
    if [ -f "/etc/os-release" ]; then
        source /etc/os-release

        if [[ ! -z "${ID}" ]]; then
            echo "${ID}"
        else
            echo "${DISTRO_UNKNOWN}"
        fi
    else
        echo "${DISTRO_UNKNOWN}"
    fi
)