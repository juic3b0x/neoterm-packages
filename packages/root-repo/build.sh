NEOTERM_PKG_HOMEPAGE=https://github.com/neoterm/neoterm-root-packages
NEOTERM_PKG_DESCRIPTION="Package repository containing programs for rooted devices"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="Henrik Grimler @Grimler91"
NEOTERM_PKG_VERSION=2.4
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_DEPENDS="neoterm-keyring"
NEOTERM_PKG_SKIP_SRC_EXTRACT=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true

neoterm_step_make_install() {
	mkdir -p $NEOTERM_PREFIX/etc/apt/sources.list.d
	{
		echo "# The root neoterm repository, with cloudflare cache"
		echo "deb https://packages-cf.neoterm.dev/apt/neoterm-root/ root stable"
		echo "# The root neoterm repository, without cloudflare cache"
		echo "# deb https://packages.neoterm.dev/apt/neoterm-root/ root stable"
	} > $NEOTERM_PREFIX/etc/apt/sources.list.d/root.list
}

neoterm_step_create_debscripts() {
	[ "$NEOTERM_PACKAGE_FORMAT" = "pacman" ] && return 0
	cat <<- EOF > ./postinst
	#!$NEOTERM_PREFIX/bin/sh
	echo "Downloading updated package list ..."
	if [ -d "$NEOTERM_PREFIX/etc/neoterm/chosen_mirrors" ] || [ -f "$NEOTERM_PREFIX/etc/neoterm/chosen_mirrors" ]; then
		pkg --check-mirror update
	else
		apt update
	fi
	exit 0
	EOF
}
