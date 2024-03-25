NEOTERM_PKG_HOMEPAGE=https://enblend.sourceforge.net/
NEOTERM_PKG_DESCRIPTION="A tool for compositing images using a Burt&Adelson multiresolution spline"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
_VERSION=4.2.0_p20161007
NEOTERM_PKG_VERSION=${_VERSION//_/}
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://dev.gentoo.org/~soap/distfiles/enblend-${_VERSION}.tar.xz
NEOTERM_PKG_SHA256=4fe05af3d697bd6b2797facc8ba5aeabdc91e233156552301f1c7686232ff4c3
NEOTERM_PKG_DEPENDS="gsl, libandroid-glob, libc++, libtiff, libvigra, littlecms"
NEOTERM_PKG_BUILD_DEPENDS="boost, boost-headers, libjpeg-turbo, libpng, zlib"

neoterm_step_pre_configure() {
	autoreconf -fi

	LDFLAGS+=" -landroid-glob"
}
