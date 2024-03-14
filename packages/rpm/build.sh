NEOTERM_PKG_HOMEPAGE=https://rpm.org/
NEOTERM_PKG_DESCRIPTION="RPM Package Manager"
NEOTERM_PKG_LICENSE="GPL-2.0, LGPL-2.0"
NEOTERM_PKG_LICENSE_FILE="COPYING"
NEOTERM_PKG_MAINTAINER="@neoterm"
_MAJOR_VERSION=4.18
NEOTERM_PKG_VERSION=${_MAJOR_VERSION}.1
NEOTERM_PKG_SRCURL=https://ftp.osuosl.org/pub/rpm/releases/rpm-${_MAJOR_VERSION}.x/rpm-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=37f3b42c0966941e2ad3f10fde3639824a6591d07197ba8fd0869ca0779e1f56
NEOTERM_PKG_DEPENDS="file, libandroid-spawn, libarchive, libbz2, libgcrypt, libiconv, liblua54, liblzma, libpopt, libsqlite, readline, zlib, zstd"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-static
--disable-openmp
"

neoterm_step_pre_configure() {
	export LUA_CFLAGS="-I$NEOTERM_PREFIX/include/lua5.4"
	export LUA_LIBS="-L$NEOTERM_PREFIX/lib/liblua5.4.so"
	LDFLAGS+=" -llua5.4 -landroid-spawn $($CC -print-libgcc-file-name)"
}
