NEOTERM_PKG_HOMEPAGE=https://ne.di.unimi.it/
NEOTERM_PKG_DESCRIPTION="Easy-to-use and powerful text editor"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="3.3.3"
NEOTERM_PKG_SRCURL=https://github.com/vigna/ne/archive/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=4f7509bb552e10348f9599f39856c8b7a2a74ea54c980dd2c9e15be212a1a6f0
NEOTERM_PKG_DEPENDS="libandroid-support, ncurses"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_MAKE_PROCESSES=1

neoterm_step_pre_configure() {
	export OPTS="$CFLAGS $CPPFLAGS"
}

neoterm_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$NEOTERM_PREFIX/bin/sh
	if [ "$NEOTERM_PACKAGE_FORMAT" = "pacman" ] || [ "\$1" = "configure" ] || [ "\$1" = "abort-upgrade" ]; then
		if [ -x "$NEOTERM_PREFIX/bin/update-alternatives" ]; then
			update-alternatives --install \
				$NEOTERM_PREFIX/bin/editor editor $NEOTERM_PREFIX/bin/ne 15
		fi
	fi
	EOF

	cat <<- EOF > ./prerm
	#!$NEOTERM_PREFIX/bin/sh
	if [ "$NEOTERM_PACKAGE_FORMAT" = "pacman" ] || [ "\$1" != "upgrade" ]; then
		if [ -x "$NEOTERM_PREFIX/bin/update-alternatives" ]; then
			update-alternatives --remove editor $NEOTERM_PREFIX/bin/ne
		fi
	fi
	EOF
}
