# If not running interactively, don't do anything
[[ $- != *i* ]] && exit

# Shell settings
export TERM=xterm-256color

# Prompt
export PS1='[\u@\h \W]\$ '

# Locale settings
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

export LOOPS_HOME=/srv/loops_home

# Autocomplete
complete -cf sudo man which
complete -F _asdf asdf

# Aliases
alias ls='ls --color=auto'
alias ll='ls -la'
alias psa='ps -aux'

alias choosenim-install='curl https://nim-lang.org/choosenim/init.sh -sSf | sh'

# Arch specific
if [[ -f "/etc/arch-release" ]]; then
	# OS specific aliases
	alias yao='yaourt'
	alias pac='sudo pacman'

	# Java
	export JAVA_HOME="/usr/lib/jvm/default-runtime"
	export JDK_HOME="${JAVA_HOME}"

fi

# gnupg home
export GNUPGHOME="${HOME}/.gnupg"

# Gopath
export GOPATH="${HOME}/devel/gopath"
export GOBIN="${GOPATH}/bin"

# Create gopath if needed
if [[ ! -e "${GOPATH}" ]]; then
	mkdir -p "${GOPATH}/src"
	mkdir "${GOPATH}/bin"
	mkdir "${GOPATH}/pkg"
fi

# Android sDK
export ANDROID_SDK_ROOT="${HOME}/Android/Sdk"

# nim
nim_dir="${HOME}/.nimble/bin"
[[ ! -e "${nim_dir}" ]] && mkdir -p "${nim_dir}"

# node.js
NVM_DIR="${HOME}/.nvm"
if [[ ! -d "${NVM_DIR}" ]]; then
	if [[ ! -e "${NVM_DIR}" ]]; then
		mkdir -p "${NVM_DIR}"
	else
		backup_name="${NVM_DIR}.bak"
		echo "NVM_DIR '${NVM_DIR}' already exist as a file. Moving to '${backup_name}'"
		while [[ -e "${backup_name}" ]]; do
			new_backup_name="${backup_name}.bak"
			mv "${backup_name}" "${new_backup_name}"
			backup_name="${new_backup_name}"
		done
		mkdir -p "${NVM_DIR}"
	fi

	if [[ -d "${NVM_DIR}" ]]; then
		if [[ -e $(which curl) ]]; then
			curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.6/install.sh | bash
			clear
		elif [[ -e $(which wget) ]]; then
			wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.6/install.sh | bash
			clear
		else
			echo "Unable to download nvm. Install 'curl' or 'wget' to the system PATH to enable nvm"
		fi
	else
		echo "Unable to create NVM_DIR '${NVM_DIR}'. Please resolve this and reopen the console"
	fi
fi

if [[ -d "${NVM_DIR}" ]]; then
	[[ -s "${NVM_DIR}/nvm.sh" ]] && source "${NVM_DIR}/nvm.sh"
	export NVM_DIR
fi

# Reason
# refmt_target=$(which refmt) >/dev/null
# refmt_name=/usr/local/bin/refmt
# if [[ -e "${refmt_target}" ]]; then
# 	if [[ ! -e "${refmt_name}" ]] || [[ "${refmt_target}" != $(readlink "${refmt_name}") ]]; then
#		if [[ "${EUID}" == "0" ]]; then
#			ln -s "${refmt_target}" "${refmt_name}"
#		else
#			echo "Linking refmt requires the use of sudo and was canceled. Use the command 'install-refmt' in stead"
#			alias install-refmt="sudo ln -s ${refmt_target} ${refmt_name} && [[ -e ${refmt_name} ]] && unalias install-refmt"
#		fi
#    fi
# fi

# Android NDK
export ANDROID_NDK=/opt/android-ndk-beta
export ANDROID_TOOLCHAINS=${ANDROID_NDK}/toolchains

# ssh gui dialogue
export SSH_ASKPASS="/usr/bin/ksshaskpass"

function _asdf() {
	local cur="${COMP_WORDS[COMP_CWORD]}"
	local cmd="${COMP_WORDS[1]}"
	local prev="${COMP_WORDS[COMP_CWORD - 1]}"
	local plugins=$(asdf plugin-list | tr '\n' ' ')

	COMPREPLY=()

	case "$cmd" in
	plugin-update)
		COMPREPLY=($(compgen -W "$plugins --all" -- $cur))
		;;
	plugin-remove | current | list | list-all)
		COMPREPLY=($(compgen -W "$plugins" -- $cur))
		;;
	install)
		if [[ "$plugins" == *"$prev"* ]]; then
			local versions=$(asdf list-all $prev)
			COMPREPLY=($(compgen -W "$versions" -- $cur))
		else
			COMPREPLY=($(compgen -W "$plugins" -- $cur))
		fi
		;;
	uninstall | where | reshim)
		if [[ "$plugins" == *"$prev"* ]]; then
			local versions=$(asdf list $prev)
			COMPREPLY=($(compgen -W "$versions" -- $cur))
		else
			COMPREPLY=($(compgen -W "$plugins" -- $cur))
		fi
		;;
	*)
		local cmds='plugin-add plugin-list plugin-remove plugin-update install uninstall current where list list-all reshim'
		COMPREPLY=($(compgen -W "$cmds" -- $cur))
		;;
	esac

	return 0
}

if [ "${BASH_SOURCE[0]}" != "" ]; then
	script="${BASH_SOURCE[0]}"
else
	script="${0}"
fi
asdf=$(
	cd $(dirname $script) &>/dev/null
	echo "${PWD}"
)

# Show info about any unavailable
# commands run by user
# source /usr/share/doc/pkgfile/command-not-found.bash

# Update path variable
export PATH="${PATH}:/opt/vscode/bin:/opt/clojurescript/bin:${HOME}/.local/bin:${nim_dir}/sbin:${asdf}/bin:${asdf}/shims:${GOBIN}"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
