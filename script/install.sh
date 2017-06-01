install_package() {
	local package_name="${1}"

	# Universal packages
	if [[ "${package_name}" == "rust" ]]; then
        # choosenim (nim version manager)
        if [[ ! -e "$(which choosenim)" ]]; then
            curl https://nim-lang.org/choosenim/init.sh -sSf | sh
            choosenim refresh
            choosenim stable
        fi
	else
		# Install non-standard or distro specific package
		if [[ "${DISTRO}" == "${DISTRO_ARCH}" ]]; then
			if [[ "${package_name}" == "sync" ]]; then
				sudo pacman -Syy --quiet
			elif [[ "${package_name}" == "yaourt" ]]; then
				source "${ABS_PATH}/arch/yaourt.sh"
			else
				sudo pacman -S --needed --noconfirm --quiet "${package_name}"
			fi
		elif [[ "${DISTRO}" == "${DISTRO_UBUNTU}" ]] || [[ "${DISTRO}" == "${DISTRO_DEBIAN}" ]]; then
			if [[ "${package_name}" == "sync" ]]; then
				sudo apt-get -qq update
			else
				sudo apt-get -qq "${package_name}"
			fi
		fi

		return 0
	fi

	return 0
} 2>&1 1>/dev/null
