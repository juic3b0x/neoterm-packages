NEOTERM_PKG_HOMEPAGE=https://github.com/openstreetmap/OSM-binary/
NEOTERM_PKG_DESCRIPTION="osmpbf is a Java/C library to read and write OpenStreetMap PBF files"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.5.0
NEOTERM_PKG_REVISION=7
NEOTERM_PKG_SRCURL=https://github.com/openstreetmap/OSM-binary/archive/v${NEOTERM_PKG_VERSION}.zip
NEOTERM_PKG_SHA256=6738a5684bb68e3f890adda1b4116a6e04df9953d96788192052be53921107cd
NEOTERM_PKG_DEPENDS="libc++, libprotobuf"
NEOTERM_PKG_GROUPS="science"

neoterm_step_pre_configure() {
	neoterm_setup_protobuf

	CPPFLAGS+=" -DPROTOBUF_USE_DLLS"
}
