NEOTERM_PKG_HOMEPAGE=https://www.gaia-gis.it/fossil/libspatialite
NEOTERM_PKG_DESCRIPTION="SQLite extension to support spatial data types and operations"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="5.1.0"
NEOTERM_PKG_SRCURL=https://www.gaia-gis.it/gaia-sins/libspatialite-sources/libspatialite-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=43be2dd349daffe016dd1400c5d11285828c22fea35ca5109f21f3ed50605080
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libgeos, proj, libfreexl, libsqlite, libxml2, librttopo"
NEOTERM_PKG_GROUPS="science"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--disable-minizip"
# Can't find generated config file spatialite/gaiaconfig.h
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	export LDFLAGS+=" -llog"
}
