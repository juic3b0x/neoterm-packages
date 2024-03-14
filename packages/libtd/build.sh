NEOTERM_PKG_HOMEPAGE=https://core.telegram.org/tdlib/
NEOTERM_PKG_DESCRIPTION="Library for building Telegram clients"
NEOTERM_PKG_LICENSE="BSL-1.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.8.0
NEOTERM_PKG_SRCURL=https://github.com/tdlib/td/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=30d560205fe82fb811cd57a8fcbc7ac853a5b6195e9cb9e6ff142f5e2d8be217
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_DEPENDS="libc++, readline, openssl (>= 1.1.1), zlib"
NEOTERM_PKG_HOSTBUILD=true

neoterm_step_host_build() {
	neoterm_setup_cmake
	cmake "-DCMAKE_BUILD_TYPE=Release" "$NEOTERM_PKG_SRCDIR"
	cmake --build . --target prepare_cross_compiling
}

neoterm_step_post_make_install() {
	# Fix rebuilds without ./clean.sh.
	rm -rf $NEOTERM_PKG_HOSTBUILD_DIR
}
