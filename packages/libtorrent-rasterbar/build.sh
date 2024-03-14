NEOTERM_PKG_HOMEPAGE=https://libtorrent.org/
NEOTERM_PKG_DESCRIPTION="A feature complete C++ bittorrent implementation focusing on efficiency and scalability"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.0.9
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/arvidn/libtorrent/releases/download/v${NEOTERM_PKG_VERSION}/libtorrent-rasterbar-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=90cd92b6061c5b664840c3d5e151d43fedb24f5b2b24e14425ffbb884ef1798e
NEOTERM_PKG_DEPENDS="boost, libc++, openssl, python"
NEOTERM_PKG_BUILD_DEPENDS="boost-headers"
NEOTERM_PKG_PYTHON_COMMON_DEPS="wheel"

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dboost-python-module-name=python
-Dpython-bindings=ON
"
