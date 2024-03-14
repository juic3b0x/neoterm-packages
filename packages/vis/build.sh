NEOTERM_PKG_HOMEPAGE=https://www.brain-dump.org/projects/vis/
NEOTERM_PKG_DESCRIPTION="Modern, legacy free, simple yet efficient vim-like editor"
NEOTERM_PKG_LICENSE="ISC"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.8"
NEOTERM_PKG_SRCURL=https://github.com/martanne/vis/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=61b10d40f15c4db2ce16e9acf291dbb762da4cbccf0cf2a80b28d9ac998a39bd
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="liblua53, libtermkey, lua-lpeg, ncurses"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	CFLAGS+=" -I$NEOTERM_PREFIX/include -I$NEOTERM_PREFIX/include/lua5.3"
}

neoterm_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$NEOTERM_PREFIX/bin/sh
	if [ "$NEOTERM_PACKAGE_FORMAT" = "pacman" ] || [ "\$1" = "configure" ] || [ "\$1" = "abort-upgrade" ]; then
		if [ -x "$NEOTERM_PREFIX/bin/update-alternatives" ]; then
			update-alternatives --install \
				$NEOTERM_PREFIX/bin/editor editor $NEOTERM_PREFIX/bin/vis 30
			update-alternatives --install \
				$NEOTERM_PREFIX/bin/vi vi $NEOTERM_PREFIX/bin/vis 10
		fi
	fi
	EOF

	cat <<- EOF > ./prerm
	#!$NEOTERM_PREFIX/bin/sh
	if [ "$NEOTERM_PACKAGE_FORMAT" = "pacman" ] || [ "\$1" != "upgrade" ]; then
		if [ -x "$NEOTERM_PREFIX/bin/update-alternatives" ]; then
			update-alternatives --remove editor $NEOTERM_PREFIX/bin/vis
			update-alternatives --remove vi $NEOTERM_PREFIX/bin/vis
		fi
	fi
	EOF
}
