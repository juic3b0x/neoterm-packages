NEOTERM_PKG_HOMEPAGE="https://userguide.mdanalysis.org/stable/formats/reference/xtc.html"
NEOTERM_PKG_DESCRIPTION="Library for reading and writing xtc, edr and trr files"
NEOTERM_PKG_GROUPS="science"
NEOTERM_PKG_LICENSE="BSD 2-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.1.4"
NEOTERM_PKG_SRCURL="ftp://ftp.gromacs.org/pub/contrib/xdrfile-$NEOTERM_PKG_VERSION.tar.gz"
NEOTERM_PKG_SHA256=e3c587c5ff24441a092fe2f3bc1dc03667bf126558f437161e779bfbcce48022

# enable fortran when we have gfortran
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--with-pic
--enable-shared
--disable-static
--disable-fortran
"
