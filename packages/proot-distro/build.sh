NEOTERM_PKG_HOMEPAGE=https://github.com/neoterm/proot-distro
NEOTERM_PKG_DESCRIPTION="NeoTerm official utility for managing proot'ed Linux distributions"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=4.10.0
NEOTERM_PKG_SRCURL=https://github.com/neoterm/proot-distro/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=571766072ecbb13666ff571d9894ff64f2f440f3c99ff9e050a7faef9c789364
NEOTERM_PKG_DEPENDS="bash, bzip2, coreutils, curl, findutils, gzip, ncurses-utils, proot (>= 5.1.107-32), sed, tar, neoterm-tools, xz-utils"
NEOTERM_PKG_SUGGESTS="bash-completion, neoterm-api"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true

neoterm_step_make_install() {
	env NEOTERM_APP_PACKAGE="$NEOTERM_APP_PACKAGE" \
		NEOTERM_PREFIX="$NEOTERM_PREFIX" \
		NEOTERM_ANDROID_HOME="$NEOTERM_ANDROID_HOME" \
		./install.sh
}

neoterm_step_create_debscripts() {
	# Distribution manjaro-aarch64 renamed to manjaro
	cat <<- EOF > ./preinst
	#!${NEOTERM_PREFIX}/bin/bash
	set -e
	PD_PLUGINS_DIR="${NEOTERM_PREFIX}/etc/proot-distro"
	PD_ROOTFS_DIR="${NEOTERM_PREFIX}/var/lib/proot-distro/installed-rootfs"

	if [ -e "\${PD_PLUGINS_DIR}/manjaro-aarch64.sh" ] && ! [ -e "\${PD_PLUGINS_DIR}/manjaro.sh" ]; then
		mv "\${PD_PLUGINS_DIR}/manjaro-aarch64.sh" "\${PD_PLUGINS_DIR}/manjaro.sh"
	fi

	if [ -e "\${PD_ROOTFS_DIR}/manjaro-aarch64" ] && ! [ -e "\${PD_ROOTFS_DIR}/manjaro" ]; then
		echo "PRoot-Distro upgrade note: renaming the distribution manjaro-aarch64 to manjaro..."

		mv "\${PD_ROOTFS_DIR}/manjaro-aarch64" "\${PD_ROOTFS_DIR}/manjaro"

		echo "PRoot-Distro upgrade note: fixing link2symlink extension files for manjaro, this will take few minutes..."

		# rewrite l2s proot symlinks
		find "\${PD_ROOTFS_DIR}/manjaro" -type l | while read -r symlink_file_name; do
			symlink_current_target=\$(readlink "\${symlink_file_name}")
			if [ "\${symlink_current_target:0:\${#PD_ROOTFS_DIR}}" != "\${PD_ROOTFS_DIR}" ]; then
				continue
			fi
			symlink_new_target=\$(sed -E "s@(\${PD_ROOTFS_DIR})/([^/]+)/(.*)@\1/manjaro/\3@g" <<< "\${symlink_current_target}")
			ln -sf "\${symlink_new_target}" "\${symlink_file_name}"
		done
	fi
	EOF
}
