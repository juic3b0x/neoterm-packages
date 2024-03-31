NEOTERM_PKG_HOMEPAGE=https://github.com/juic3b0x/x11-packages
NEOTERM_PKG_DESCRIPTION="Package repository containing X11 programs and libraries"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=8.4
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_DEPENDS="neoterm-keyring"
NEOTERM_PKG_SKIP_SRC_EXTRACT=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true

neoterm_step_make_install() {
	mkdir -p $NEOTERM_PREFIX/etc/apt/sources.list.d
	{
		echo "# The x11 neoterm repository, with cloudflare cache"
		echo "deb https://repo.theworkjoy.com/apt/neoterm-x11/ x11 stable"
		echo "# The x11 neoterm repository, without cloudflare cache"
		echo "# deb https://repo.theworkjoy.com/apt/neoterm-x11/ x11 stable"
	} > $NEOTERM_PREFIX/etc/apt/sources.list.d/x11.list
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
