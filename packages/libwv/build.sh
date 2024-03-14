NEOTERM_PKG_HOMEPAGE=https://wvware.sourceforge.net/
NEOTERM_PKG_DESCRIPTION="A library which allows access to Microsoft Word files"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.2.9
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://ftp-osl.osuosl.org/pub/gentoo/distfiles/wv-${NEOTERM_PKG_VERSION}.tar.gz
#NEOTERM_PKG_SRCURL=http://abiword.org/downloads/wv/${NEOTERM_PKG_VERSION}/wv-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=4c730d3b325c0785450dd3a043eeb53e1518598c4f41f155558385dd2635c19d
NEOTERM_PKG_DEPENDS="glib, libgsf, libpng, libxml2, zlib"

neoterm_step_pre_configure() {
	NOCONFIGURE=1 ./autogen.sh
}
