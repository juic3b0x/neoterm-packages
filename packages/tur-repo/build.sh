NEOTERM_PKG_HOMEPAGE=https://github.com/juic3b0x-user-repository/tur
NEOTERM_PKG_DESCRIPTION="A single and trusted place for all unofficial/less popular neoterm packages"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm-user-repository"
NEOTERM_PKG_VERSION=1.0.1
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_SKIP_SRC_EXTRACT=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true

neoterm_step_make_install() {
	mkdir -p $NEOTERM_PREFIX/etc/apt/sources.list.d
	echo "deb https://tur.kcubeterm.com tur-packages tur tur-on-device tur-continuous" > $NEOTERM_PREFIX/etc/apt/sources.list.d/tur.list
	## tur gpg key
	mkdir -p $NEOTERM_PREFIX/etc/apt/trusted.gpg.d
	install -Dm600 $NEOTERM_PKG_BUILDER_DIR/tur.gpg $NEOTERM_PREFIX/etc/apt/trusted.gpg.d/
}

neoterm_step_create_debscripts() {
	[ "$NEOTERM_PACKAGE_FORMAT" = "pacman" ] && return 0
	echo "#!$NEOTERM_PREFIX/bin/sh" > postinst
	echo "echo Downloading updated package list ..." >> postinst
	echo "apt update" >> postinst
	echo "exit 0" >> postinst
}
