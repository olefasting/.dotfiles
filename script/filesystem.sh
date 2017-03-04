#!/usr/bin/env bash

create_dir() {
    local path="${1}"

    if [[ -z "${path}" ]]; then
        echo "Unable to create folder. No path and name specified." >&2
        exit 1
    fi

    [[ -d "${path}" ]] && rm -rf "${path}"

    if [[ -e "${path}" ]]; then
        echo "Unable to create '${path}' as it already exists." >&2
        exit 1
    fi

    mkdir -p "${path}"
}
