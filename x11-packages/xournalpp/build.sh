NEOTERM_PKG_HOMEPAGE=https://github.com/xournalpp/xournalpp
NEOTERM_PKG_DESCRIPTION="A hand note taking software"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_LICENSE_FILE="LICENSE, copyright.txt"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.2.3"
NEOTERM_PKG_SRCURL=https://github.com/xournalpp/xournalpp/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=8817abd1794760c2a3be3a35e56a5588a51e517bc591384fa321994d50e14e7c
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="gdk-pixbuf, glib, gtk3, libandroid-execinfo, libc++, libcairo, librsvg, libsndfile, libx11, libxi, libxml2, libzip, pango, poppler, portaudio, zlib"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DHELP2MAN=NO
"
