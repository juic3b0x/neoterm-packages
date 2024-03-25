NEOTERM_PKG_HOMEPAGE=https://assimp.sourceforge.net/index.html
NEOTERM_PKG_DESCRIPTION="Library to import various well-known 3D model formats in an uniform manner"
NEOTERM_PKG_LICENSE="BSD"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="5.3.1"
NEOTERM_PKG_SRCURL=https://github.com/assimp/assimp/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=a07666be71afe1ad4bc008c2336b7c688aca391271188eb9108d0c6db1be53f1
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libc++, zlib"
NEOTERM_PKG_BUILD_DEPENDS="boost, boost-headers"
NEOTERM_PKG_BREAKS="assimp-dev"
NEOTERM_PKG_REPLACES="assimp-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="-DASSIMP_BUILD_SAMPLES=OFF"
