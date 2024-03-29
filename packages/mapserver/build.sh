NEOTERM_PKG_HOMEPAGE=https://mapserver.org/
NEOTERM_PKG_DESCRIPTION="MapServer is CGI-based platform for publishing spatial data and interactive mapping applications to the web"
NEOTERM_PKG_MAINTAINER="Bjoern Schilberg @BjoernSchilberg"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_LICENSE_FILE="LICENSE.md"
NEOTERM_PKG_VERSION=8.0.1
NEOTERM_PKG_REVISION=4
NEOTERM_PKG_SRCURL=https://download.osgeo.org/mapserver/mapserver-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=79d23595ef95d61d3d728ae5e60850a3dbfbf58a46953b4fdc8e6e0ffe5748ba
NEOTERM_PKG_DEPENDS="freetype, gdal, libc++, libcairo, libcurl, libgeos, libiconv, libjpeg-turbo, libpng, libprotobuf-c, libxml2, proj"
NEOTERM_PKG_BREAKS="mapserver-dev"
NEOTERM_PKG_REPLACES="mapserver-dev"
NEOTERM_PKG_GROUPS="science"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_CXX_STANDARD=14
-DWITH_GDAL=ON
-DWITH_GEOS=ON
-DWITH_OGR=ON
-DWITH_PROJ=ON
-DWITH_POSTGIS=OFF
-DWITH_KML=ON
-DWITH_WCS=ON
-DWITH_SOS=ON
-DWITH_WMS=ON
-DWITH_CLIENT_WMS=ON
-DWITH_WFS=ON
-DWITH_CLIENT_WFS=ON
-DWITH_THREAD_SAFETY=OFF
-DWITH_FCGI=OFF
-DWITH_CAIRO=ON
-DWITH_CURL=ON
-DWITH_MYSQL=OFF
-DWITH_FRIBIDI=OFF
-DWITH_HARFBUZZ=OFF
-DWITH_GIF=OFF
-DWITH_EXEMPI=OFF
"
