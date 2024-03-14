NEOTERM_PKG_HOMEPAGE=https://os.ghalkes.nl/tilde/
NEOTERM_PKG_DESCRIPTION="A text editor for the console/terminal"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.1.3
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://os.ghalkes.nl/dist/tilde-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=6b86ffaa5c632c9055f74fca713c5bf8420ee60718850dc16a95abe49fa2641a
NEOTERM_PKG_DEPENDS="libc++, libt3config, libt3highlight, libt3widget, libtranscript, libunistring"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--without-gettext"

neoterm_step_post_get_source() {
	sed -i 's/ -s / /g' Makefile.in
	rm -f src/tilde
	find src -type f | xargs -n 1 sed -i 's:tilde/::g'
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
}
