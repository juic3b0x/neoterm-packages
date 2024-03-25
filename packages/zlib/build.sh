NEOTERM_PKG_HOMEPAGE=https://www.zlib.net/
NEOTERM_PKG_DESCRIPTION="Compression library implementing the deflate compression method found in gzip and PKZIP"
NEOTERM_PKG_LICENSE="ZLIB"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.3.1"
NEOTERM_PKG_SRCURL=https://github.com/madler/zlib/releases/download/v${NEOTERM_PKG_VERSION}/zlib-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=38ef96b8dfe510d42707d9c781877914792541133e1870841463bfa73f883e32
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BREAKS="ndk-sysroot (<< 19b-3), zlib-dev"
NEOTERM_PKG_REPLACES="ndk-sysroot (<< 19b-3), zlib-dev"

neoterm_step_pre_configure() {
	if [ "$NEOTERM_ARCH" = "aarch64" ]; then
		CFLAGS+=" -march=armv8-a+crc"
		CXXFLAGS+=" -march=armv8-a+crc"
	fi

	# Fix relocation issues when linking with libz.a
	CFLAGS+=" -fPIC"
	CXXFLAGS+=" -fPIC"

	# Fix linker script error for zlib 1.3
	LDFLAGS+=" -Wl,--undefined-version"
}

neoterm_step_configure() {
	"$NEOTERM_PKG_SRCDIR/configure" --prefix=$NEOTERM_PREFIX --shared
}
