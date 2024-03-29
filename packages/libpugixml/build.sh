NEOTERM_PKG_HOMEPAGE=https://pugixml.org/
NEOTERM_PKG_DESCRIPTION="Light-weight, simple and fast XML parser for C++ with XPath support"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.14"
NEOTERM_PKG_SRCURL=https://github.com/zeux/pugixml/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=610f98375424b5614754a6f34a491adbddaaec074e9044577d965160ec103d2e
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libc++"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_SHARED_LIBS=ON
"
