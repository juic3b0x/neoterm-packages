NEOTERM_PKG_HOMEPAGE=https://www.nongnu.org/icoutils/
NEOTERM_PKG_DESCRIPTION="Extracts and converts images in MS Windows(R) icon and cursor files"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.32.3
NEOTERM_PKG_SRCURL=https://savannah.nongnu.org/download/icoutils/icoutils-$NEOTERM_PKG_VERSION.tar.bz2
NEOTERM_PKG_SHA256=17abe02d043a253b68b47e3af69c9fc755b895db68fdc8811786125df564c6e0
NEOTERM_PKG_DEPENDS="libpng, perl"

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--mandir=$NEOTERM_PREFIX/share/man
"
