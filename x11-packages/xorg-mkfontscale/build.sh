NEOTERM_PKG_HOMEPAGE=https://xorg.freedesktop.org/
NEOTERM_PKG_DESCRIPTION="Create an index of scalable font files for X"
# Licenses: MIT, HPND
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="COPYING"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.2.2
NEOTERM_PKG_SRCURL=https://xorg.freedesktop.org/archive/individual/app/mkfontscale-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=8ae3fb5b1fe7436e1f565060acaa3e2918fe745b0e4979b5593968914fe2d5c4
NEOTERM_PKG_DEPENDS="findutils, freetype, libfontenc, zlib"
NEOTERM_PKG_BUILD_DEPENDS="xorg-util-macros, xorgproto"
NEOTERM_PKG_CONFLICTS="xorg-mkfontdir"
NEOTERM_PKG_REPLACES="xorg-mkfontdir"

neoterm_step_create_debscripts() {
	cp -f "${NEOTERM_PKG_BUILDER_DIR}/postinst" ./
	cp -f "${NEOTERM_PKG_BUILDER_DIR}/postrm"   ./
	cp -f "${NEOTERM_PKG_BUILDER_DIR}/triggers" ./
	sed -i "s|@NEOTERM_PREFIX@|$NEOTERM_PREFIX|g" ./{post{inst,rm},triggers}
}
