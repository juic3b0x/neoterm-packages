NEOTERM_PKG_HOMEPAGE=https://www.gnu.org/software/libiconv/
NEOTERM_PKG_DESCRIPTION="An implementation of iconv()"
NEOTERM_PKG_LICENSE="LGPL-2.1, GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.17
NEOTERM_PKG_SRCURL=https://ftp.gnu.org/pub/gnu/libiconv/libiconv-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=8f74213b56238c85a50a5329f77e06198771e70dd9a739779f4c02f65d971313
NEOTERM_PKG_BREAKS="libandroid-support (<= 24), libiconv-dev, libandroid-support-dev"
NEOTERM_PKG_REPLACES="libandroid-support (<= 24), libiconv-dev, libandroid-support-dev"

# Enable extra encodings (such as CP437) needed by some programs:
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--enable-extra-encodings"
