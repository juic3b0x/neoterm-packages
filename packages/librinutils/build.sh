TERMUX_PKG_HOMEPAGE=https://github.com/shlomif/rinutils
TERMUX_PKG_DESCRIPTION="A C11 / gnu11 utilities C library"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@neoterm"
TERMUX_PKG_VERSION="0.10.2"
TERMUX_PKG_SRCURL=https://github.com/shlomif/rinutils/archive/refs/tags/${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=d395f19b858b41f046c6ed298bc32c1cd9fae17b50089d7bd900c6a852ca6d12
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DWITH_TEST_SUITE=OFF
"
