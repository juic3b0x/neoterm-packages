NEOTERM_PKG_HOMEPAGE=http://www.httrack.com
NEOTERM_PKG_DESCRIPTION="It allows you to download a World Wide Web site from the Internet"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.49.4
NEOTERM_PKG_SRCURL=https://ftp.debian.org/debian/pool/main/h/httrack/httrack_${NEOTERM_PKG_VERSION}.orig.tar.gz
NEOTERM_PKG_SHA256=2b796688615f0fc44ee42ce8509295d0509ab8795ffd6fd2404baf90b86deb7a
NEOTERM_PKG_DEPENDS="httrack-data, libandroid-execinfo, libiconv, openssl, zlib"
NEOTERM_PKG_BREAKS="httrack-dev"
NEOTERM_PKG_REPLACES="httrack-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--docdir=$NEOTERM_PREFIX/share/httrack/html
--with-zlib=$NEOTERM_PREFIX
LIBS=-liconv
"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_post_configure() {
	make clean
}
