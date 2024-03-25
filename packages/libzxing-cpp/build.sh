NEOTERM_PKG_HOMEPAGE=https://github.com/nu-book/zxing-cpp
NEOTERM_PKG_DESCRIPTION="An open-source, multi-format 1D/2D barcode image processing library implemented in C++"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.1.0
NEOTERM_PKG_SRCURL=https://github.com/nu-book/zxing-cpp/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=6d54e403592ec7a143791c6526c1baafddf4c0897bb49b1af72b70a0f0c4a3fe
NEOTERM_PKG_DEPENDS="libc++"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_EXAMPLES=OFF
-DBUILD_BLACKBOX_TESTS=OFF
"
