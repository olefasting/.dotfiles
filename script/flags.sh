#!/usr/bin/env bash

parse_flags() {
	local flags=()

	# Defaults
	[[ -z "${INSTALL_DEPS}" ]] && INSTALL_DEPS="true"
	[[ -z "${SERVER}" ]] && SERVER="false"
	[[ -z "${NO_XORG}" ]] && NO_XORG="false"

	# Parse
	flags=("${flags[@]}" "INSTALL_DEPS:     Dependencies will be (re)installed if true          [${INSTALL_DEPS}]")
	flags=("${flags[@]}" "SERVER:           Only server relevent packages will be installed     [${SERVER}]")
	[[ "${SERVER}" == "true" ]] && NO_XORG="true"
	flags=("${flags[@]}" "NO_XORG:          Xorg will not be installed                          [${NO_XORG}]")
	if [[ "${#flags[@]}" > "0" ]]; then
		local i=0
		local cnt="${#flags[@]}"

		while [[ "${i}" < "${cnt}" ]]; do
			echo "${flags["${i}"]}" >&2

			let "i+=1"
		done
	fi
}