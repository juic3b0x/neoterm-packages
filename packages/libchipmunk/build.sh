NEOTERM_PKG_HOMEPAGE="http://chipmunk2d.net"
NEOTERM_PKG_DESCRIPTION="A fast and lightweight 2D game physics library"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="7.0.3"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL="https://github.com/slembcke/Chipmunk2D/archive/refs/tags/Chipmunk-$NEOTERM_PKG_VERSION.tar.gz"
NEOTERM_PKG_SHA256=1e6f093812d6130e45bdf4cb80280cb3c93d1e1833d8cf989d554d7963b7899a
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_BLACKLISTED_ARCHES="arm"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_SHARED=ON
-DBUILD_STATIC=OFF
"
