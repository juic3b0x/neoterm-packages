NEOTERM_PKG_HOMEPAGE=https://os.ghalkes.nl/t3/libt3widget.html
NEOTERM_PKG_DESCRIPTION="A library of widgets and dialogs to facilitate construction of easy-to-use terminal-based programs"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.2.2
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://os.ghalkes.nl/dist/libt3widget-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=9eb7e1d0ccdfc917f18ba1785a2edb4faa6b0af8b460653d962abf91136ddf1c
NEOTERM_PKG_DEPENDS="libc++, libt3config, libt3key, libt3window, libtranscript, libunistring, pcre2"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--without-gettext
--without-x11
--without-gpm
"

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
		AC_PROG_CXX
		AC_OUTPUT
	EOF
	touch install-sh
	cp "$NEOTERM_SCRIPTDIR/scripts/config.sub" ./
	cp "$NEOTERM_SCRIPTDIR/scripts/config.guess" ./
	autoreconf -fi
	./configure --host=$NEOTERM_HOST_PLATFORM
	popd
	export LIBTOOL=$libtooldir/libtool

	CXXFLAGS+=" $CPPFLAGS"
	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
