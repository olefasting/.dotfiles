install() {
	local package="${1}"

    if [[ "${DISTRO}" == "${DISTRO_ARCH}" ]]; then
        if [[ "${package}" == 'git' ]]; then
            sudo pacman -S --noconfirm --quiet git
        elif [[ "${package}" == 'curl' ]]; then
            sudo pacman -S --noconfirm --quiet curl
        elif [[ "${package}" == 'yaourt' ]]; then                
            source script/arch/yaourt.sh
        elif [[ "${package}" == 'bash-completion' ]]; then
            yaourt -S --noconfirm bash-completion
        fi
    elif [[ "${DISTRO}" == "${DISTRO_UBUNTU}" ]] || [[ "${DISTRO}" == "${DISTRO_DEBIAN}" ]]; then
        if [[ "${package}" == 'git' ]]; then
            sudo apt-get install git
        elif [[ "${package}" == 'curl' ]]; then
            sudo apt-get install curl
        elif [[ "${package}" == 'bash-completion' ]]; then
            sudo apt-get install bash-completion            
        fi
    fi

    if [[ "${package}" == 'rustup' ]]; then
        curl https://sh.rustup.rs -sSf | sh
    fi
} 2>&1 1>/dev/null