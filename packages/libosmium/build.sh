NEOTERM_PKG_HOMEPAGE=https://osmcode.org/libosmium/
NEOTERM_PKG_DESCRIPTION="Library for reading from and writing to OSM files in XML and PBF formats"
NEOTERM_PKG_LICENSE="BSL-1.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.20.0"
NEOTERM_PKG_SRCURL=https://github.com/osmcode/libosmium/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=3d3e0873c6aaabb3b2ef4283896bebf233334891a7a49f4712af30ca6ed72477
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_DEPENDS="boost, boost-headers, liblz4, libprotozero"
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_GROUPS="science"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="-DINSTALL_UTFCPP=ON -DBUILD_EXAMPLES=OFF -DBUILD_DATA_TESTS=OFF"
