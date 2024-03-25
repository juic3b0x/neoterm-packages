NEOTERM_PKG_HOMEPAGE=https://drobilla.net/software/lilv.html
NEOTERM_PKG_DESCRIPTION="A C library to make the use of LV2 plugins as simple as possible for applications"
NEOTERM_PKG_LICENSE="ISC"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.24.24"
NEOTERM_PKG_SRCURL=https://download.drobilla.net/lilv-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=6bb6be9f88504176d0642f12de809b2b9e2dc55621a68adb8c7edb99aefabb4f
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libsndfile, lv2, serd, sord, sratom"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dbindings_py=disabled
"
