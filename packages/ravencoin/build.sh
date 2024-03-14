NEOTERM_PKG_HOMEPAGE=https://ravencoin.org/
NEOTERM_PKG_DESCRIPTION="A peer-to-peer blockchain, handling the efficient creation and transfer of assets from one party to another"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=4.6.1
NEOTERM_PKG_REVISION=4
NEOTERM_PKG_SRCURL=https://github.com/RavenProject/Ravencoin/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=42e8444e9e21eecfed1a546dffe6f2418271e890038a7d9d9a856b376a6284e8
NEOTERM_PKG_DEPENDS="boost, libc++, libevent, libzmq, miniupnpc, openssl"
NEOTERM_PKG_BUILD_DEPENDS="boost-headers, libdb"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-tests
--disable-wallet
--with-boost=$NEOTERM_PREFIX/lib
--with-boost-libdir=$NEOTERM_PREFIX/lib
"

neoterm_step_pre_configure() {
	autoreconf -fi

	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
