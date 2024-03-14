NEOTERM_PKG_HOMEPAGE="https://libspatialindex.github.io"
NEOTERM_PKG_DESCRIPTION="C++ implementation of R*-tree, an MVR-tree and a TPR-tree with C API"
NEOTERM_PKG_GROUPS="science"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.9.3"
NEOTERM_PKG_SRCURL="https://github.com/libspatialindex/libspatialindex/archive/refs/tags/$NEOTERM_PKG_VERSION.tar.gz"
NEOTERM_PKG_SHA256=7b44340a3edc55c11abfc453bb60f148b29f569cef9e1148583e76132e9c7379
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libc++"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DSIDX_BUILD_TESTS=OFF
-DBUILD_SHARED_LIBS=ON
"
