TERMUX_PKG_HOMEPAGE=https://www.libssh2.org
TERMUX_PKG_DESCRIPTION="Client-side library implementing the SSH2 protocol"
TERMUX_PKG_LICENSE="BSD 3-Clause"
TERMUX_PKG_MAINTAINER="@neoterm"
TERMUX_PKG_VERSION=1.11.0
TERMUX_PKG_SRCURL=https://www.libssh2.org/download/libssh2-$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=3736161e41e2693324deb38c26cfdc3efe6209d634ba4258db1cecff6a5ad461
TERMUX_PKG_DEPENDS="openssl, zlib"
TERMUX_PKG_BREAKS="libssh2-dev"
TERMUX_PKG_REPLACES="libssh2-dev"
