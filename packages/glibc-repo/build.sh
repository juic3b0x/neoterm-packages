NEOTERM_PKG_HOMEPAGE=https://github.com/juic3b0x/glibc-packages
NEOTERM_PKG_DESCRIPTION="A package repository containing glibc-based programs and libraries"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm-pacman"
NEOTERM_PKG_VERSION=1.0
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_SKIP_SRC_EXTRACT=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true

neoterm_step_make_install() {
	mkdir -p $NEOTERM_PREFIX/etc/apt/sources.list.d
	{
		echo "# The glibc neoterm repository, with cloudflare cache"
		echo "deb https://packages-cf.neoterm.dev/apt/neoterm-glibc/ glibc stable"
		echo "# The glibc neoterm repository, without cloudflare cache"
		echo "# deb https://packages.neoterm.dev/apt/neoterm-glibc/ glibc stable"
	} > $NEOTERM_PREFIX/etc/apt/sources.list.d/glibc.list
}

neoterm_step_create_debscripts() {
	[ "$NEOTERM_PACKAGE_FORMAT" = "pacman" ] && return 0
	echo "#!$NEOTERM_PREFIX/bin/sh" > postinst
	echo "echo Downloading updated package list ..." >> postinst
	echo "apt update" >> postinst
	echo "exit 0" >> postinst
}
