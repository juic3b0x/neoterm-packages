NEOTERM_PKG_HOMEPAGE=https://www.gnu.org/software/zile/
NEOTERM_PKG_DESCRIPTION="Lightweight clone of the Emacs text editor"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.6.2
NEOTERM_PKG_SRCURL=https://mirrors.kernel.org/gnu/zile/zile-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=77eb7daff3c98bdc88daa1ac040dccca72b81dc32fc3166e079dd7a63e42c741
NEOTERM_PKG_DEPENDS="glib, libgee, ncurses"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_header_spawn_h=no
gl_cv_have_weak=no
"

neoterm_step_post_configure() {
	# zile uses help2man to build the zile.1 man page, which would require
	# a host build.
	sed 's|@docdir@|$PREFIX/share/doc/zile|g' \
		$NEOTERM_PKG_SRCDIR/doc/zile.1.in \
		> $NEOTERM_PKG_BUILDDIR/doc/zile.1
	touch -d "next hour" $NEOTERM_PKG_BUILDDIR/doc/zile.1*
}

neoterm_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$NEOTERM_PREFIX/bin/sh
	if [ "$NEOTERM_PACKAGE_FORMAT" = "pacman" ] || [ "\$1" = "configure" ] || [ "\$1" = "abort-upgrade" ]; then
		if [ -x "$NEOTERM_PREFIX/bin/update-alternatives" ]; then
			update-alternatives --install \
				$NEOTERM_PREFIX/bin/editor editor $NEOTERM_PREFIX/bin/zile 35
		fi
	fi
	EOF

	cat <<- EOF > ./prerm
	#!$NEOTERM_PREFIX/bin/sh
	if [ "$NEOTERM_PACKAGE_FORMAT" = "pacman" ] || [ "\$1" != "upgrade" ]; then
		if [ -x "$NEOTERM_PREFIX/bin/update-alternatives" ]; then
			update-alternatives --remove editor $NEOTERM_PREFIX/bin/zile
		fi
	fi
	EOF
}
