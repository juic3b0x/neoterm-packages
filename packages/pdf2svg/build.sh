NEOTERM_PKG_HOMEPAGE=http://www.cityinthesky.co.uk/opensource/pdf2svg/
NEOTERM_PKG_DESCRIPTION="A PDF to SVG converter"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.2.3
NEOTERM_PKG_REVISION=10
NEOTERM_PKG_SRCURL=https://github.com/db9052/pdf2svg/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=4fb186070b3e7d33a51821e3307dce57300a062570d028feccd4e628d50dea8a
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="glib, libcairo, poppler"

neoterm_step_pre_configure() {
	CXXFLAGS+=" -std=c++17"
}
