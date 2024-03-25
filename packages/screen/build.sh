NEOTERM_PKG_HOMEPAGE=https://www.gnu.org/software/screen/
NEOTERM_PKG_DESCRIPTION="Terminal multiplexer with VT100/ANSI terminal emulation"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="4.9.1"
NEOTERM_PKG_SRCURL=https://mirrors.kernel.org/gnu/screen/screen-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=26cef3e3c42571c0d484ad6faf110c5c15091fbf872b06fa7aa4766c7405ac69
NEOTERM_PKG_DEPENDS="ncurses, libcrypt"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-socket-dir
--enable-colors256
"

neoterm_step_pre_configure() {
	# Run autoreconf since we have patched configure.ac
	autoreconf -fi
	CFLAGS+=" -DGETUTENT"
	export LIBS="-lcrypt"
}

neoterm_step_post_configure() {
	echo '#define HAVE_SVR4_PTYS 1' >> $NEOTERM_PKG_BUILDDIR/config.h
	echo 'mousetrack on' > "$NEOTERM_PREFIX/etc/screenrc"
}
