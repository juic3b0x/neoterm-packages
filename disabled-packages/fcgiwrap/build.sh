NEOTERM_PKG_HOMEPAGE=http://nginx.localdomain.pl/wiki/FcgiWrap
NEOTERM_PKG_DESCRIPTION="A simple server for running CGI applications over FastCGI"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_VERSION=1.1.0
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/gnosek/fcgiwrap/archive/$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=4c7de0db2634c38297d5fcef61ab4a3e21856dd7247d49c33d9b19542bd1c61f
NEOTERM_PKG_DEPENDS="fcgi"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--mandir=/share/man"

neoterm_step_pre_configure() {
	CFLAGS+=" -Wno-error=implicit-fallthrough"
	autoreconf -i
}
