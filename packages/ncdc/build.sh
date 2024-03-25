NEOTERM_PKG_HOMEPAGE=https://dev.yorhel.nl/ncdc
NEOTERM_PKG_DESCRIPTION="Modern and lightweight direct connect client with a friendly ncurses interface"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.23.1
NEOTERM_PKG_SRCURL=https://dev.yorhel.nl/download/ncdc-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=95881214077a5b3c24fbbaf020ada0d084ee3b596a7c3cc1e0e68aaac4c9b5e6
NEOTERM_PKG_DEPENDS="glib, libbz2, libgnutls, libsqlite, ncurses, zlib"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_post_configure() {
	# Cross compiling steps documented in ncdc README
	gcc $NEOTERM_PKG_SRCDIR/deps/makeheaders.c -o makeheaders
	gcc -I. $NEOTERM_PKG_SRCDIR/doc/gendoc.c -o gendoc
	touch -d "next hour" makeheaders gendoc
}
