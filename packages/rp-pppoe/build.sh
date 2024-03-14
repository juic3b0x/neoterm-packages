NEOTERM_PKG_HOMEPAGE=https://dianne.skoll.ca/projects/rp-pppoe/
NEOTERM_PKG_DESCRIPTION="A PPP-over-Ethernet redirector for pppd"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=4.0
#NEOTERM_PKG_SRCURL=https://dianne.skoll.ca/projects/rp-pppoe/download/rp-pppoe-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SRCURL=https://fossies.org/linux/misc/rp-pppoe-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=41ac34e5db4482f7a558780d3b897bdbb21fae3fef4645d2852c3c0c19d81cea
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-static
"

neoterm_step_pre_configure() {
	NEOTERM_PKG_SRCDIR=$NEOTERM_PKG_SRCDIR/src
	NEOTERM_PKG_BUILDDIR=$NEOTERM_PKG_SRCDIR
}
