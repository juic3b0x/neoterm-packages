NEOTERM_PKG_HOMEPAGE=http://joe-editor.sourceforge.net
NEOTERM_PKG_DESCRIPTION="Wordstar like text editor"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_DEPENDS="ncurses"
NEOTERM_PKG_CONFLICTS="jupp"
NEOTERM_PKG_VERSION=4.6
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://sourceforge.net/projects/joe-editor/files/JOE%20sources/joe-${NEOTERM_PKG_VERSION}/joe-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=495a0a61f26404070fe8a719d80406dc7f337623788e445b92a9f6de512ab9de
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--disable-termcap"

neoterm_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$NEOTERM_PREFIX/bin/sh
	if [ "$NEOTERM_PACKAGE_FORMAT" = "pacman" ] || [ "\$1" = "configure" ] || [ "\$1" = "abort-upgrade" ]; then
		if [ -x "$NEOTERM_PREFIX/bin/update-alternatives" ]; then
			update-alternatives --install \
				$NEOTERM_PREFIX/bin/editor editor $NEOTERM_PREFIX/bin/joe 10
		fi
	fi
	EOF

	cat <<- EOF > ./prerm
	#!$NEOTERM_PREFIX/bin/sh
	if [ "$NEOTERM_PACKAGE_FORMAT" = "pacman" ] || [ "\$1" != "upgrade" ]; then
		if [ -x "$NEOTERM_PREFIX/bin/update-alternatives" ]; then
			update-alternatives --remove editor $NEOTERM_PREFIX/bin/joe
		fi
	fi
	EOF
}
