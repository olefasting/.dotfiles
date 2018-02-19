[[ $- != *i* ]] && exit

# wifi
export COUNTRY=NO

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
[[ -e $(which hcloud) ]] && source <(hcloud completion bash)

# Aliases
alias ls='ls --color=auto'
alias ll='ls -la'
alias psa='ps -aux'

# llvm
alias llvm-ar=llvm-ar-5.0
alias llvm-c-test=llvm-c-test-5.0
alias llvm-dlltool=llvm-dlltool-5.0
alias llvm-link=llvm-link-5.0
alias llvm-mt=llvm-mt-5.0
alias llvm-profdata=llvm-profdata-5.0
alias llvm-split=llvm-split-5.0
alias llvm-as=llvm-as-5.0
alias llvm-cvtres=llvm-cvtres-5.0
alias llvm-dsymutil=llvm-dsymutil-5.0
alias llvm-lto2=llvm-lto2-5.0
alias llvm-nm=llvm-nm-5.0
alias llvm-ranlib=llvm-ranlib-5.0
alias llvm-stress=llvm-stress-5.0
alias llvm-bcanalyzer=llvm-bcanalyzer-5.0
alias llvm-cxxdump=llvm-cxxdump-5.0
alias llvm-dwarfdump=llvm-dwarfdump-5.0
alias llvm-lto=llvm-lto-5.0
alias llvm-objdump=llvm-objdump-5.0
alias llvm-readelf=llvm-readelf-5.0
alias llvm-readelf=llvm-strings-5.0
alias llvm-cat=llvm-cat-5.0
alias llvm-cxxfilt=llvm-cxxfilt-5.0
alias llvm-dwp=llvm-dwp-5.0
alias llvm-mc=llvm-mc-5.0
alias llvm-opt-report=llvm-opt-report-5.0
alias llvm-readobj=llvm-readobj-5.0
alias llvm-symbolizer=llvm-symbolizer-5.0
alias llvm-config=llvm-config-5.0
alias llvm-diff=llvm-diff-5.0
alias llvm-extract=llvm-extract-5.0
alias llvm-mcmarkup=llvm-mcmarkup-5.0
alias llvm-pdbutil=llvm-pdbutil-5.0
alias llvm-rtdyld=llvm-rtdyld-5.0
alias llvm-tblgen=llvm-tblgen-5.0
alias llvm-cov=llvm-cov-5.0
alias llvm-dis=llvm-dis-5.0
alias llvm-lib=llvm-lib-5.0
alias llvm-modextract=llvm-modextract-5.0
alias llvm-PerfectShuffle=llvm-PerfectShuffle-5.0
alias llvm-size=llvm-size-5.0
alias llvm-xray=llvm-xray-5.0

# nim
nim_dir=/opt/nim
nim_repo=https://github.com/nim-lang/Nim.git
if [[ ! -e "${nim_dir}" ]]; then
	[[ -e $(which git) ]] && sudo git clone "${nim_repo}" "${nim_dir}"
fi

nimble_dir="${HOME}/.nimble"
mkdir -p "${nimble_dir}/bin"

export PATH="${PATH}:${nimble_dir}/bin:${nim_dir}/bin"

unset nim_dir
unset nim_repo
unset nimble_dir

# Rotate xorg logs
alias rotate_xorg_logs='
	xorg_log_dir="${HOME}/.local/share/xorg"
	xorg_log_target="${xorg_log_dir}/Xorg.0.log" 
	[[ ! -e "${xorg_log_dir}" ]] && mkdir -p "${xorg_log_dir}"
	if [[ -e $(which Xorg) ]]; then
		if [[ -e "${xorg_log_target}" ]]; then
			cnt=0
			prev=0
			done="false"
			while [[ "${done}" != "true" ]]; do
				echo "${done}"
				prev="${cnt}"
				cur_file="${xorg_log_dir}/Xorg.${cnt}.log"
				if [[ -e "${cur_file}" ]]; then
				        let cnt=$cnt+1
			       	else
					echo "Xorg log rotation"
					echo "[move] ${xorg_log_target} => ${cur_file}"
					mv "${xorg_log_target}" "${cur_file}"
					echo "[newf] ${xorg_log_target}"
					touch "${xorg_log_target}"
					done="true"
				fi
			done
			unset cnt
			unset prev
			unset done
		fi
	fi
	unset xorg_log_diri
	unset xorg_log_target
'

# Rootless xinit fix
alias startx='startx -- -keeptty > "${xorg_log_target}" 2>&1'

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

# Haskell
eval "$(stack --bash-completion-script stack)"

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

# Ruby
export PATH="$PATH:/home/oasf/.gem/ruby/2.4.0/bin"

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
#    	fi
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

# local stuff
[[ -e "${HOME}/.bash_local" ]] && source "${HOME}/.bash_local"
