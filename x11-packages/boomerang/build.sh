NEOTERM_PKG_HOMEPAGE=https://github.com/BoomerangDecompiler/boomerang
NEOTERM_PKG_DESCRIPTION="A general, open source machine code decompiler"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_LICENSE_FILE="LICENSE.TERMS"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.5.2
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/BoomerangDecompiler/boomerang/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=1d2c9c2f5de1a3e1d5fe3879e82bca268d1c49e6ba3d0a7848695f18c594384d
NEOTERM_PKG_DEPENDS="capstone, libc++, qt5-qtbase"
NEOTERM_PKG_BUILD_DEPENDS="qt5-qtbase-cross-tools"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DBOOMERANG_BUILD_UNIT_TESTS=OFF
"
