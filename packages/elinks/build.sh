NEOTERM_PKG_HOMEPAGE=https://github.com/rkd77/elinks
NEOTERM_PKG_DESCRIPTION="Full-Featured Text WWW Browser"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.17.0"
NEOTERM_PKG_SRCURL=https://github.com/rkd77/elinks/releases/download/v${NEOTERM_PKG_VERSION}/elinks-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=58c73a6694dbb7ccf4e22cee362cf14f1a20c09aaa4273343e8b7df9378b330e
NEOTERM_PKG_DEPENDS="libexpat, libiconv, libidn, openssl, libbz2, zlib"
NEOTERM_PKG_AUTO_UPDATE=true

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--enable-256-colors
--enable-true-color
--mandir=$NEOTERM_PREFIX/share/man
--with-openssl
--without-brotli
--without-zstd
"

NEOTERM_MAKE_PROCESSES=1

neoterm_step_pre_configure() {
	./autogen.sh
}
