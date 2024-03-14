NEOTERM_PKG_HOMEPAGE=https://github.com/hboetes/mg
NEOTERM_PKG_DESCRIPTION="microscopic GNU Emacs-style editor"
NEOTERM_PKG_LICENSE="Public Domain"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="20230406"
NEOTERM_PKG_SRCURL=https://github.com/hboetes/mg/archive/$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=fa5d39658a689929a931105297a67ef55c7fbec250c77f09c9d464aca9539e96
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d{8}"
NEOTERM_PKG_DEPENDS="libbsd, ncurses"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_post_get_source() {
	rm -f CMakeLists.txt
}

neoterm_step_pre_configure() {
	CFLAGS+=" $CPPFLAGS -fcommon"
}

neoterm_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$NEOTERM_PREFIX/bin/sh
	if [ "$NEOTERM_PACKAGE_FORMAT" = "pacman" ] || [ "\$1" = "configure" ] || [ "\$1" = "abort-upgrade" ]; then
		if [ -x "$NEOTERM_PREFIX/bin/update-alternatives" ]; then
			update-alternatives --install \
				$NEOTERM_PREFIX/bin/editor editor $NEOTERM_PREFIX/bin/mg 30
		fi
	fi
	EOF

	cat <<- EOF > ./prerm
	#!$NEOTERM_PREFIX/bin/sh
	if [ "$NEOTERM_PACKAGE_FORMAT" = "pacman" ] || [ "\$1" != "upgrade" ]; then
		if [ -x "$NEOTERM_PREFIX/bin/update-alternatives" ]; then
			update-alternatives --remove editor $NEOTERM_PREFIX/bin/mg
		fi
	fi
	EOF
}
