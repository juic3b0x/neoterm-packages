NEOTERM_PKG_HOMEPAGE=https://wiki.debian.org/Aptitude
NEOTERM_PKG_DESCRIPTION="terminal-based package manager"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.8.13
NEOTERM_PKG_SRCURL=http://deb.debian.org/debian/pool/main/a/aptitude/aptitude_$NEOTERM_PKG_VERSION.orig.tar.xz
NEOTERM_PKG_SHA256=0ef50cb5de27215dd30de74dd9b46b318f017bd0ec3f5c4735df7ac0beb40248
NEOTERM_PKG_DEPENDS="apt, boost, libcwidget, libsigc++-2.0, libsqlite, libxapian, ncurses"
NEOTERM_PKG_BUILD_DEPENDS="boost-headers, googletest"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-tests
--disable-docs
--disable-boost-lib-checks
--with-boost=$NEOTERM_PREFIX
--with-package-state-loc=$NEOTERM_PREFIX/var/lib/aptitude
--with-lock-loc=$NEOTERM_PREFIX/var/lock/aptitude
--disable-nls
"

neoterm_step_pre_configure() {
	CXXFLAGS+=" -DNCURSES_WIDECHAR=1"
}

neoterm_step_create_debscripts() {
	cat <<- EOF > postrm
	#!$NEOTERM_PREFIX/bin/sh
	case "\$1" in
	purge)
		rm -fr $NEOTERM_PREFIX/var/lib/aptitude
		rm -f $NEOTERM_PREFIX/var/log/aptitude $NEOTERM_PREFIX/var/log/aptitude.[0-9].gz
		;;
	esac
	EOF
}
