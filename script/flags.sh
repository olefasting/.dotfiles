#!/usr/bin/env bash

parse_flags() {
	local flags=()

	# Defaults
	[[ -z "${NO_DEPENDENCIES}" ]] && NO_DEPENDENCIES="false"
	[[ -z "${SERVER}" ]] && SERVER="false"
	[[ -z "${NO_XORG}" ]] && NO_XORG="false"

	# Parse
	flags=("${flags[@]}" "NO_DEPENDENCIES:     Dependencies will not be (re)installed if true      [${NO_DEPENDENCIES}]")
	flags=("${flags[@]}" "SERVER:              Only server relevent packages will be installed     [${SERVER}]")
	[[ "${SERVER}" == "true" ]] && NO_XORG="true"
	flags=("${flags[@]}" "NO_XORG:             Xorg will not be installed                          [${NO_XORG}]")
	if [[ "${#flags[@]}" > "0" ]]; then
		local i=0
		local cnt="${#flags[@]}"

		while [[ "${i}" < "${cnt}" ]]; do
			echo "${flags["${i}"]}" >&2

			let "i+=1"
		done
	fi
}
