NEOTERM_PKG_HOMEPAGE=https://zmap.io/
NEOTERM_PKG_DESCRIPTION="A fast single packet network scanner designed for Internet-wide network surveys"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1:3.0.0
NEOTERM_PKG_SRCURL=https://github.com/zmap/zmap/archive/refs/tags/v${NEOTERM_PKG_VERSION#*:}.tar.gz
NEOTERM_PKG_SHA256=e3151cdcdf695ab7581e01a7c6ee78678717d6a62ef09849b34db39682535454
NEOTERM_PKG_DEPENDS="json-c, libgmp, libpcap, libunistring"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DRESPECT_INSTALL_PREFIX_CONFIG=ON
"
