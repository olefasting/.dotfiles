#!/usr/bin/env bash

parse_flags() {
	local flags=()

	# Defaults
	[[ -z "${NO_DEPS}" ]] && NO_DEPS="true"
	[[ -z "${DO_BACKUPS}" ]] && DO_BACKUPS="false"
	[[ -z "${SERVER}" ]] && SERVER="false"
	[[ -z "${NO_XORG}" ]] && NO_XORG="false"

	# Parse
	flags=("${flags[@]}" "NO_DEPS:             Dependencies will not be (re)installed if true      [${NO_DEPS}]")
	flags=("${flags[@]}" "DO_BACKUPS	   Already existing files will be backed up	       [${DO_BACKUPS}]")
	flags=("${flags[@]}" "SERVER:              Only server relevent packages will be installed     [${SERVER}]")
	[[ "${SERVER}" == "true" ]] && NO_XORG="true"
	flags=("${flags[@]}" "NO_XORG:             Xorg will not be installed                          [${NO_XORG}]")
	if [[ "${#flags[@]}" > "0" ]]; then
		local i=0
		local cnt="${#flags[@]}"

		while [[ "${i}" < "${cnt}" ]]; do
			echo "${flags["${i}"]}" >&2

			let i+=1
		done
	fi
}
