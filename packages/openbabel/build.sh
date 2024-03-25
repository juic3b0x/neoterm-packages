NEOTERM_PKG_HOMEPAGE=http://openbabel.org/wiki/Main_Page
NEOTERM_PKG_DESCRIPTION="Open Babel is a chemical toolbox designed to speak the many languages of chemical data"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.1.1
NEOTERM_PKG_REVISION=8
NEOTERM_PKG_SRCURL=https://github.com/openbabel/openbabel/archive/openbabel-${NEOTERM_PKG_VERSION//./-}.tar.gz
NEOTERM_PKG_SHA256=c97023ac6300d26176c97d4ef39957f06e68848d64f1a04b0b284ccff2744f02
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_SED_REGEXP='s/^[^-]*-//; s/-/./g'
NEOTERM_PKG_DEPENDS="libc++, libcairo, libxml2, zlib"
NEOTERM_PKG_BUILD_DEPENDS="boost, boost-headers, eigen"
NEOTERM_PKG_BREAKS="openbabel-dev"
NEOTERM_PKG_REPLACES="openbabel-dev"
NEOTERM_PKG_GROUPS="science"
# MAEPARSER gives an error related to boost's unit_test_framework during configure
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="-DWITH_MAEPARSER=off -DWITH_COORDGEN=off"
