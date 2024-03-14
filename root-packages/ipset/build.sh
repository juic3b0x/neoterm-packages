NEOTERM_PKG_HOMEPAGE=https://ipset.netfilter.org
NEOTERM_PKG_DESCRIPTION="Administration tool for kernel IP sets"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="Vishal Biswas @vishalbiswas"
NEOTERM_PKG_VERSION="7.21"
NEOTERM_PKG_SRCURL=https://ipset.netfilter.org/ipset-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=e2c6ce4fcf3acb3893ca5d35c86935f80ad76fc5ccae601185842df760e0bc69
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libmnl"
NEOTERM_PKG_BREAKS="ipset-dev"
NEOTERM_PKG_REPLACES="ipset-dev"
NEOTERM_PKG_BUILD_DEPENDS="libtool"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--with-kmod=no
"

neoterm_step_pre_configure() {
	# Workaround for version script error
	LDFLAGS+=" -Wl,--undefined-version"
}
