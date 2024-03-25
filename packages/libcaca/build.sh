NEOTERM_PKG_HOMEPAGE=http://caca.zoy.org/wiki/libcaca
NEOTERM_PKG_DESCRIPTION="Graphics library that outputs text instead of pixels"
NEOTERM_PKG_LICENSE="WTFPL, GPL-2.0, ISC, LGPL-2.1"
NEOTERM_PKG_LICENSE_FILE="COPYING, COPYING.GPL, COPYING.ISC, COPYING.LGPL"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.99.beta20
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/cacalabs/libcaca/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=3edb8763a8f888ed4d4b85b3a056e81c840d5d27f79bdebc0b991688b23084f2
NEOTERM_PKG_DEPENDS="imlib2, libc++, ncurses, zlib"
NEOTERM_PKG_BREAKS="libcaca-dev"
NEOTERM_PKG_REPLACES="libcaca-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-doc
--disable-java
--disable-python
--disable-ruby
--enable-imlib2
"
NEOTERM_PKG_HOSTBUILD=true

neoterm_step_host_build() {
	local _PREFIX_FOR_BUILD=$NEOTERM_PKG_HOSTBUILD_DIR/prefix

	local AUTOCONF_BUILD_SH=$NEOTERM_SCRIPTDIR/packages/autoconf/build.sh
	local AUTOCONF_SRCURL=$(bash -c ". $AUTOCONF_BUILD_SH; echo \$NEOTERM_PKG_SRCURL")
	local AUTOCONF_SHA256=$(bash -c ". $AUTOCONF_BUILD_SH; echo \$NEOTERM_PKG_SHA256")
	local AUTOCONF_TARFILE=$NEOTERM_PKG_CACHEDIR/$(basename $AUTOCONF_SRCURL)
	neoterm_download $AUTOCONF_SRCURL $AUTOCONF_TARFILE $AUTOCONF_SHA256
	mkdir -p autoconf
	cd autoconf
	tar xf $AUTOCONF_TARFILE --strip-components=1
	./configure --prefix=$_PREFIX_FOR_BUILD
	make -j $NEOTERM_MAKE_PROCESSES
	make install
}

neoterm_step_pre_configure() {
	local _PREFIX_FOR_BUILD=$NEOTERM_PKG_HOSTBUILD_DIR/prefix
	export PATH=$_PREFIX_FOR_BUILD/bin:$PATH

	autoreconf -fi
}

neoterm_step_post_configure() {
	if [ $NEOTERM_ARCH = x86_64 ]; then
		# Remove troublesome asm usage:
		perl -p -i -e 's/#define HAVE_FLDLN2 1//' $NEOTERM_PKG_BUILDDIR/config.h
	fi
}
