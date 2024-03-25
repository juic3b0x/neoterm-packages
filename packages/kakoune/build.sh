NEOTERM_PKG_HOMEPAGE=https://github.com/mawww/kakoune
NEOTERM_PKG_DESCRIPTION="Code editor heavily inspired by Vim"
NEOTERM_PKG_LICENSE="Unlicense"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2023.08.05"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/mawww/kakoune/releases/download/v$NEOTERM_PKG_VERSION/kakoune-$NEOTERM_PKG_VERSION.tar.bz2
NEOTERM_PKG_SHA256=3e45151e0addd3500de2d6a29b5aacf2267c42bb256d44a782e73defb29cda5c
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libc++"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_MAKE_ARGS=" -C src debug=no "

neoterm_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$NEOTERM_PREFIX/bin/sh
	if [ "$NEOTERM_PACKAGE_FORMAT" = "pacman" ] || [ "\$1" = "configure" ] || [ "\$1" = "abort-upgrade" ]; then
		if [ -x "$NEOTERM_PREFIX/bin/update-alternatives" ]; then
			update-alternatives --install \
				$NEOTERM_PREFIX/bin/editor editor $NEOTERM_PREFIX/bin/kak 45
		fi
	fi
	EOF

	cat <<- EOF > ./prerm
	#!$NEOTERM_PREFIX/bin/sh
	if [ "$NEOTERM_PACKAGE_FORMAT" = "pacman" ] || [ "\$1" != "upgrade" ]; then
		if [ -x "$NEOTERM_PREFIX/bin/update-alternatives" ]; then
			update-alternatives --remove editor $NEOTERM_PREFIX/bin/kak
		fi
	fi
	EOF
}
