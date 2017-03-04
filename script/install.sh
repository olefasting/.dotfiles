install() {
    local package="${1}"
    
    if [[ "${DO_REINSTALL}" == 'true' ]] || [[ "${NO_PKG_UPGRADES}" != 'true' ]]; then
        if [[ "${DISTRO}" == "${DISTRO_ARCH}" ]]; then
            if [[ "${package}" == 'git' ]]; then
                sudo pacman -S --noconfirm --quiet git
            elif [[ "${package}" == 'yaourt' ]]; then
                source script/arch/yaourt.sh
            elif [[ "${package}" == 'bash-completion' ]]; then
                yaourt -S --noconfirm bash-completion
            fi
        elif [[ "${DISTRO}" == "${DISTRO_UBUNTU}" ]] || [[ "${DISTRO}" == "${DISTRO_DEBIAN}" ]]; then
            if [[ "${package}" == 'git' ]]; then
                sudo apt-get install git
            elif [[ "${package}" == 'bash-completion' ]]; then
                sudo apt-get install bash-completion
            fi
        fi
    fi
} 2>&1 1> /dev/null