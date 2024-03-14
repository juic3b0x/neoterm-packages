NEOTERM_PKG_HOMEPAGE=https://os.ghalkes.nl/t3/libt3window.html
NEOTERM_PKG_DESCRIPTION="A library providing a windowing abstraction on terminals"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.4.1
NEOTERM_PKG_SRCURL=https://os.ghalkes.nl/dist/libt3window-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=4c14d3f4f946637fd6c3fa23ef7511fa505880946e151406d5e16f645d24e792
NEOTERM_PKG_DEPENDS="libtranscript, libunistring, ncurses"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--without-gettext"

neoterm_step_post_get_source() {
	sed -i 's/ -s / /g' Makefile.in
}

neoterm_step_pre_configure() {
	local libtooldir=$NEOTERM_PKG_TMPDIR/_libtool
	mkdir -p $libtooldir
	pushd $libtooldir
	cat > configure.ac <<-EOF
		AC_INIT
		LT_INIT
		AC_OUTPUT
	EOF
	touch install-sh
	cp "$NEOTERM_SCRIPTDIR/scripts/config.sub" ./
	cp "$NEOTERM_SCRIPTDIR/scripts/config.guess" ./
	autoreconf -fi
	./configure --host=$NEOTERM_HOST_PLATFORM
	popd
	export LIBTOOL=$libtooldir/libtool

	CFLAGS+=" $CPPFLAGS"
}
