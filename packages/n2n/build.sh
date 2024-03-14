NEOTERM_PKG_HOMEPAGE=https://github.com/ntop/n2n
NEOTERM_PKG_DESCRIPTION="A light VPN software"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.1.1
NEOTERM_PKG_SRCURL=https://github.com/ntop/n2n/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=311f89d147558ae4dfb0d8f8698f5429c05a3e19a9d25cb8c85bd73d02aff834
NEOTERM_PKG_DEPENDS="libcap, libpcap, openssl, zstd"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_FORCE_CMAKE=false
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-miniupnp
--disable-natpmp
--enable-pcap
--enable-cap
--disable-pthread
--with-zstd
--with-openssl
"
NEOTERM_PKG_EXTRA_MAKE_ARGS="PREFIX=$NEOTERM_PREFIX"

neoterm_step_pre_configure() {
	autoreconf -fi
}
