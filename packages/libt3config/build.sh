NEOTERM_PKG_HOMEPAGE=https://os.ghalkes.nl/t3/libt3config.html
NEOTERM_PKG_DESCRIPTION="A library for reading and writing configuration files"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.0.0
NEOTERM_PKG_SRCURL=https://os.ghalkes.nl/dist/libt3config-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=1aba7262ed79b11b30f93d02183aafde49c9d6655f08ac438b26af3151908c01
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
}
