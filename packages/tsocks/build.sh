NEOTERM_PKG_HOMEPAGE=http://tsocks.sf.net
NEOTERM_PKG_DESCRIPTION="transparent network access through a SOCKS 4 or 5 proxy"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="Oliver Schmidhauser @Neo-Oli"
NEOTERM_PKG_VERSION=1.8beta5
NEOTERM_PKG_REVISION=4
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/project/tsocks/tsocks/1.8%20beta%205/tsocks-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=849d7ef5af80d03e76cc05ed9fb8fa2bcc2b724b51ebfd1b6be11c7863f5b347
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS=" --with-conf=$NEOTERM_PREFIX/etc/tsocks.conf"

neoterm_step_post_get_source() {
	cp $NEOTERM_PKG_SRCDIR/tsocks-1.8/* $NEOTERM_PKG_SRCDIR/
}

neoterm_step_pre_configure() {
	cp $NEOTERM_PKG_SRCDIR/tsocks.conf.complex.example $NEOTERM_PREFIX/etc/tsocks.conf
}
