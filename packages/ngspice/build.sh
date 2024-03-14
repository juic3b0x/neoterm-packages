NEOTERM_PKG_HOMEPAGE=https://ngspice.sourceforge.net/
NEOTERM_PKG_DESCRIPTION="A mixed-level/mixed-signal circuit simulator"
NEOTERM_PKG_LICENSE="BSD 3-Clause, LGPL-2.1"
NEOTERM_PKG_LICENSE_FILE="COPYING"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="42"
NEOTERM_PKG_SRCURL=https://github.com/imr/ngspice/archive/refs/tags/ngspice-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=d6e566aa72bd289ca9a4f985ab0bcace4e5530fe9e970e18f2f9e99715f96174
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_UPDATE_VERSION_SED_REGEXP="s/ngspice-//"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--enable-xspice
--enable-cider
--with-readline=yes
--enable-openmp
"
NEOTERM_PKG_HOSTBUILD=true
NEOTERM_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS="
--with-x=no
--enable-cider
--enable-xspice
"
NEOTERM_PKG_DEPENDS="fftw, libc++, ncurses, readline"
NEOTERM_PKG_GROUPS="science"

neoterm_step_host_build() {
	autoreconf -fi $NEOTERM_PKG_SRCDIR
	$NEOTERM_PKG_SRCDIR/configure $NEOTERM_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS

	# compiles ngspice codemodel preprocessor
	cd src/xspice/cmpp && make
}

neoterm_step_pre_configure() {
	autoreconf -fi
}

neoterm_step_post_configure() {
	cp -ru $NEOTERM_PKG_HOSTBUILD_DIR/src/xspice/cmpp \
		src/xspice
	cd src/xspice/cmpp && cp cmpp build/cmpp

	# prevents building again on copied precompiled cmpp.
	touch -d "next hour" *
}
