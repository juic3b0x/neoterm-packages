NEOTERM_PKG_HOMEPAGE=https://postgis.net
NEOTERM_PKG_DESCRIPTION="Spatial database extender for PostgreSQL object-relational database"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="3.4.2"
NEOTERM_PKG_SRCURL=https://download.osgeo.org/postgis/source/postgis-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=c8c874c00ba4a984a87030af6bf9544821502060ad473d5c96f1d4d0835c5892
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="gdal, json-c, libc++, libgeos, libiconv, libprotobuf-c, libxml2, pcre2, postgresql, proj"

# both configure script and Makefile(s) look for files in current
# directory rather than srcdir, so need to build in source
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	CXXFLAGS+=" -std=c++14"
}
