NEOTERM_PKG_HOMEPAGE="https://spglib.github.io/spglib/index.html"
NEOTERM_PKG_DESCRIPTION="C library for finding and handling crystal symmetries"
NEOTERM_PKG_GROUPS="science"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.3.1"
NEOTERM_PKG_SRCURL="https://github.com/spglib/spglib/archive/refs/tags/v$NEOTERM_PKG_VERSION.tar.gz"
NEOTERM_PKG_SHA256=6eb977053b35cd80eb2b5c3fa506a538ff2dad7092a43a612f4f0d4dc2069253
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DWITH_Fortran=OFF
-DUSE_OMP=ON
"
