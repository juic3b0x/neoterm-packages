NEOTERM_PKG_HOMEPAGE=https://potrace.sourceforge.net
NEOTERM_PKG_DESCRIPTION="Tool for transforming a bitmap into a smooth, scalable image"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.16
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://distfiles.macports.org/potrace/potrace-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=be8248a17dedd6ccbaab2fcc45835bb0502d062e40fbded3bc56028ce5eb7acc
NEOTERM_PKG_DEPENDS="zlib"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--with-libpotrace
"
