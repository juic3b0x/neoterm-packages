NEOTERM_PKG_HOMEPAGE=https://feh.finalrewind.org/
NEOTERM_PKG_DESCRIPTION="Fast and light imlib2-based image viewer"
# License: MIT-feh
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="COPYING"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="3.10.2"
NEOTERM_PKG_SRCURL=https://feh.finalrewind.org/feh-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=5f94a77de25c5398876f0cf431612d782b842f4db154d2139b778c8f196e8969
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="imlib2, libcurl, libexif, libpng, libx11, libxinerama"
NEOTERM_PKG_BUILD_DEPENDS="libxt"
NEOTERM_PKG_RECOMMENDS="libjpeg-turbo-progs"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="exif=1 help=1 verscmp=0"

neoterm_step_pre_configure() {
	CFLAGS+=" -I${NEOTERM_PREFIX}/include"
}
