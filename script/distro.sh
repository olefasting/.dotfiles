#!/usr/bin/env bash

distro=""

distro_arch="arch"
distro_ubuntu="ubuntu"
distro_debian="debian"
distro_unknown="unknown"

distro_LIST=("${distro_arch}" "${distro_ubuntu}" "${distro_debian}")


determine_distro() {
    if [[ ! -z "${distro}" ]]; then
        local i = 0
        local cnt = "${#distro_LIST[@]}"

        while [[ "${i}" < "${cnt}" ]]; do
            if [[ "${distro}" == "${distro_LIST[${i}]}" ]]; then
                # Manually set distro found
                echo `"Environment variable 'distro' was set, and the specified distro '${distro}' has been selected."`

                # Break loop by setting i to cnt
                let "i=${cnt}"
            elif [[ "${i}" == "${cnt}-1" ]]; then
                # Last item and no match was found.
                echo `"Environment variable 'distro' was set, but the specified distro '${distro}' is not supported.
                Trying auto detect in stead."`
                
                # Set to blank and try next step.
                distro=""
            else
                let "i+=1"
            fi
        done
    fi

    if [[ -z "${distro}" ]]; then
        if [ -f "/etc/os-release" ]; then
            distro="$(get_distro_name)"
        else
            distro="${distro_unknown}"
            
        fi
    fi
}

get_distro_name() (
    if [ -f "/etc/os-release" ]; then
        source /etc/os-release

        if [[ ! -z "${ID}" ]]; then
            echo "${ID}"
        else
            echo "${distro_unknown}"
        fi
    else
        echo "${distro_unknown}"
    fi
)
