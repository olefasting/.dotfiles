#!/usr/bin/env bash
spacer='----------------------------------------------------------------'

# Error handling
# http://stackoverflow.com/questions/2870992/automatic-exit-from-bash-shell-script-on-error
abort() {
	echo "ERROR: Setup was interrupted"
	exit 1
}

trap 'abort' 0

# Check that user is not root
if [[ "${EUID}" == "0" ]]; then
	echo "Please call this script as a regular user."
	exit 1
fi

# Determine absolute path
if [[ ! -d "${abs_path}" ]]; then
	abs_path="${BASH_SOURCE[0]}"

	if [ -h "${abs_path}" ]; then
		while [ -h "${abs_path}" ]; do
			abs_path=$(readlink "${abs_path}")
		done
	fi

	pushd . >/dev/null
	cd $(dirname ${abs_path}) >/dev/null
	abs_path=$(pwd)
	popd >/dev/null
fi

# Source scripts
source script/filesystem.sh
source script/distro.sh
source script/flags.sh
source script/install.sh

# This function installs a dotfile. It needs two parameters; the path to the dotfile to be
# installed, and the link name to use when installing.
create_link() {
	echo "- '${2}' => '${1}'"

	# Check for required params
	if [[ -z "${1}" ]]; then
		echo "Error creating link: Dotfile path is empty"
		return 1
	fi
	if [[ -z "${2}" ]]; then
		echo "Error creating link: Link name is empty"
		return 1
	fi

	# Check that dotfile exists
	if [[ ! -e "${1}" ]]; then
        ls -la "${1}"
		echo "Error creating link: The specified file or directory '${1}' does not exist"
		return 1
	fi

	# Check for existing dotfile
	if [[ -e "${2}" ]]; then
		if [[ -L "${2}" ]]; then
            # Backup and delete
            echo "File or directory '${2}' already exists.
    Backing it up as '${2}.old' before overwrite"
            mv "${2}" "${2}.old"
        else
            rm -f "${2}"
		fi
	fi

	# Create link
	ln -s "${1}" "${2}"

	return 0
}

# Determine distro
determine_distro

# Start
echo "
Starting setup for '${distro}' in '${HOME}'"
echo "${spacer}"

# Flags
parse_flags

# Create needed folders
create_dir "${abs_path}/backup"
create_dir "${abs_path}/build"

if [[ "${NO_DEPENDENCIES}" != "true" ]]; then
	echo "
    Installing dependencies:"
	echo "${spacer}"

	# Refresh repos
	install_package sync

	# Install dependencies
	install_package git
	install_package curl
	install_package rust
	install_package bash-completion
	install_package yaourt

	echo "
Done installing dependencies
    "
fi

# Create bash profile
echo '
Linking files'
echo "${spacer}"
create_link "${abs_path}/bash/.bash_profile" "${HOME}/.bash_profile"
create_link "${abs_path}/bash/.bashrc" "${HOME}/.bashrc"
create_link "${abs_path}/bash/.bash_logout" "${HOME}/.bash_logout"
source "${HOME}/.bash_profile"

# julia
create_link "${abs_path}/julia/.juliarc.jl" "${HOME}/.juliarc.jl"

# vim
create_link "${abs_path}/vim/.vimrc" "${HOME}/.vimrc"

# tmux
create_link "${abs_path}/tmux/.tmux.conf" "${HOME}/.tmux.conf"

if [[ "${NO_XORG}" != "true" ]]; then
	# xorg
	create_link "${abs_path}/xorg/.xinitrc" "${HOME}/.xinitrc"
	create_link "${abs_path}/xorg/.xprofile" "${HOME}/.xprofile"

	# vscode
	mkdir -p "${HOME}/.config/Code/User"
	create_link "${abs_path}/vscode/snippets" "${HOME}/.config/Code/User/snippets"
	create_link "${abs_path}/vscode/settings.json" "${HOME}/.config/Code/User/settings.json"

	# vscode insiders
	mkdir -p "${HOME}/.config/Code - Insiders/User"
	create_link "${abs_path}/vscode/snippets" "${HOME}/.config/Code - Insiders/User/snippets"
	create_link "${abs_path}/vscode/settings.json" "${HOME}/.config/Code - Insiders/User/settings.json"

	# [[ -e "${HOME}/.config/plasma-workspace/env/xprofile.sh" ]] && rm -f "${HOME}/.config/plasma-workspace/env/xprofile.sh"
	# touch "${HOME}/.config/plasma-workspace/env/xprofile.sh"
	# chmod +x "${HOME}/.config/plasma-workspace/env/xprofile.sh"

	# Generate xprofile file
	# mkdir -p "${HOME}/.config/plasma-workspace/env"
	# echo '#!/usr/bin/env bash' >"${HOME}/.config/plasma-workspace/env/xprofile.sh"
	# echo '# generated by dotfiles/setup.sh' >>"${HOME}/.config/plasma-workspace/env/xprofile.sh"
	# echo >>"${HOME}/.config/plasma-workspace/env/xprofile.sh"
	# echo 'source ~/.bashenv' >>"${HOME}/.config/plasma-workspace/env/xprofile.sh"
	# echo >>"${HOME}/.config/plasma-workspace/env/xprofile.sh"
fi

trap : 0

echo '
Setup completed
'
