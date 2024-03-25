NEOTERM_PKG_HOMEPAGE=https://dvdauthor.sourceforge.net/
NEOTERM_PKG_DESCRIPTION="Generates a DVD-Video movie from a valid MPEG-2 stream"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.7.2
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/dvdauthor/dvdauthor-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=3020a92de9f78eb36f48b6f22d5a001c47107826634a785a62dfcd080f612eb7
NEOTERM_PKG_DEPENDS="fontconfig, freetype, fribidi, graphicsmagick, libdvdread, libpng, libxml2"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_prog_MAGICKCONFIG=GraphicsMagick-config
"
