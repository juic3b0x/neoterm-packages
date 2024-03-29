NEOTERM_PKG_HOMEPAGE="https://geographiclib.sourceforge.io"
NEOTERM_PKG_DESCRIPTION="Utilities and C++ library to solve some geodesic problems"
NEOTERM_PKG_GROUPS="science"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.3"
NEOTERM_PKG_SRCURL="https://sourceforge.net/projects/geographiclib/files/distrib-C%2B%2B/GeographicLib-$NEOTERM_PKG_VERSION.tar.gz/download"
NEOTERM_PKG_SHA256=3114847839453ee6bbe2228e41dc73cad6de6160055442b747adc9c76f0a3198
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libc++"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_FORCE_CMAKE=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_SHARED_LIBS=ON
-DBUILD_BOTH_LIBS=OFF
"
