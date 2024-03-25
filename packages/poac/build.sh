NEOTERM_PKG_HOMEPAGE=https://github.com/poac-dev/poac
NEOTERM_PKG_DESCRIPTION="A package manager and build system for C++"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@SunPodder"
NEOTERM_PKG_VERSION="0.9.3"
NEOTERM_PKG_SRCURL="https://github.com/poac-dev/poac/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz"
NEOTERM_PKG_SHA256=122aa46923e3e93235305b726617df7df747ed7a26072ccd6b87ffaf84a33aed
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_BUILD_DEPENDS="nlohmann-json"
NEOTERM_PKG_DEPENDS="libtbb, libgit2, libcurl"
NEOTERM_PKG_SUGGESTS="clang, make, pkg-config, fmt"
NEOTERM_PKG_BLACKLISTED_ARCHES="arm, i686"

neoterm_step_make() {
	make RELEASE=1 -j$NEOTERM_MAKE_PROCESSES
}

neoterm_step_make_install() {
	install -Dm755 -t $NEOTERM_PREFIX/bin build-out/poac
}

