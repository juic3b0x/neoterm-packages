NEOTERM_PKG_HOMEPAGE=https://abseil.io/
NEOTERM_PKG_DESCRIPTION="Abseil C++ Common Libraries"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
# Do not forget to rebuild revdeps along with EVERY "major" version bump.
NEOTERM_PKG_VERSION="20230802.1"
NEOTERM_PKG_SRCURL=https://github.com/abseil/abseil-cpp/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=987ce98f02eefbaf930d6e38ab16aa05737234d7afbab2d5c4ea7adbe50c28ed
NEOTERM_PKG_AUTO_UPDATE=false # updating this will break libprotobuf
NEOTERM_PKG_DEPENDS="libc++"
NEOTERM_PKG_CONFLICTS="libgrpc (<< 1.52.0-1)"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_SHARED_LIBS=ON
"
