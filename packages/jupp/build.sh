NEOTERM_PKG_HOMEPAGE=http://www.mirbsd.org/jupp.htm
NEOTERM_PKG_DESCRIPTION="User friendly full screen text editor"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.1jupp41
NEOTERM_PKG_SRCURL=http://www.mirbsd.org/MirOS/dist/jupp/joe-${NEOTERM_PKG_VERSION}.tgz
NEOTERM_PKG_SHA256=7bb8ea8af519befefff93ec3c9e32108d7f2b83216c9bc7b01aef5098861c82f
NEOTERM_PKG_DEPENDS="ncurses"
NEOTERM_PKG_CONFLICTS="joe"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-dependency-tracking
--disable-getpwnam
--disable-termcap
--disable-termidx
--enable-sysconfjoesubdir=/jupp
"

neoterm_step_post_get_source() {
	chmod +x $NEOTERM_PKG_SRCDIR/configure
}

neoterm_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$NEOTERM_PREFIX/bin/sh
	if [ "$NEOTERM_PACKAGE_FORMAT" = "pacman" ] || [ "\$1" = "configure" ] || [ "\$1" = "abort-upgrade" ]; then
		if [ -x "$NEOTERM_PREFIX/bin/update-alternatives" ]; then
			update-alternatives --install \
				$NEOTERM_PREFIX/bin/editor editor $NEOTERM_PREFIX/bin/jupp 10
		fi
	fi
	EOF

	cat <<- EOF > ./prerm
	#!$NEOTERM_PREFIX/bin/sh
	if [ "$NEOTERM_PACKAGE_FORMAT" = "pacman" ] || [ "\$1" != "upgrade" ]; then
		if [ -x "$NEOTERM_PREFIX/bin/update-alternatives" ]; then
			update-alternatives --remove editor $NEOTERM_PREFIX/bin/jupp
		fi
	fi
	EOF
}
