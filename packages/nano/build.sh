NEOTERM_PKG_HOMEPAGE=https://www.nano-editor.org/
NEOTERM_PKG_DESCRIPTION="Small, free and friendly text editor"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=7.2
NEOTERM_PKG_SRCURL=https://nano-editor.org/dist/latest/nano-$NEOTERM_PKG_VERSION.tar.xz
NEOTERM_PKG_SHA256=86f3442768bd2873cec693f83cdf80b4b444ad3cc14760b74361474fc87a4526
NEOTERM_PKG_DEPENDS="libandroid-support, ncurses"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_header_glob_h=no
ac_cv_header_pwd_h=no
--disable-libmagic
--enable-utf8
--with-wordbounds
"
NEOTERM_PKG_CONFFILES="etc/nanorc"
NEOTERM_PKG_RM_AFTER_INSTALL="bin/rnano share/man/man1/rnano.1 share/nano/man-html"

neoterm_step_post_make_install() {
	# Configure nano to use syntax highlighting:
	NANORC=$NEOTERM_PREFIX/etc/nanorc
	echo include \"$NEOTERM_PREFIX/share/nano/\*nanorc\" > $NANORC
}

neoterm_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$NEOTERM_PREFIX/bin/sh
	if [ "$NEOTERM_PACKAGE_FORMAT" = "pacman" ] || [ "\$1" = "configure" ] || [ "\$1" = "abort-upgrade" ]; then
		if [ -x "$NEOTERM_PREFIX/bin/update-alternatives" ]; then
			update-alternatives --install \
				$NEOTERM_PREFIX/bin/editor editor $NEOTERM_PREFIX/bin/nano 20
		fi
	fi
	EOF

	cat <<- EOF > ./prerm
	#!$NEOTERM_PREFIX/bin/sh
	if [ "$NEOTERM_PACKAGE_FORMAT" = "pacman" ] || [ "\$1" != "upgrade" ]; then
		if [ -x "$NEOTERM_PREFIX/bin/update-alternatives" ]; then
			update-alternatives --remove editor $NEOTERM_PREFIX/bin/nano
		fi
	fi
	EOF
}
