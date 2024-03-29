NEOTERM_PKG_HOMEPAGE=https://dl.matroska.org/downloads/libmatroska/
NEOTERM_PKG_DESCRIPTION="Matroska library"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.7.1
NEOTERM_PKG_SRCURL=https://github.com/Matroska-Org/libmatroska/archive/release-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=64763443947833e6c17f1f555f4bb0df6c9f91881810d9d5e0f0bad3622d308b
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_METHOD=repology
NEOTERM_PKG_DEPENDS="libc++, libebml"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_SHARED_LIBS=ON
"
