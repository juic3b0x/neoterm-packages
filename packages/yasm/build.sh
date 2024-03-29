NEOTERM_PKG_HOMEPAGE=https://yasm.tortall.net/
NEOTERM_PKG_DESCRIPTION="Assembler supporting the x86 and AMD64 instruction sets"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.3.0
NEOTERM_PKG_REVISION=6
NEOTERM_PKG_SRCURL=https://www.tortall.net/projects/yasm/releases/yasm-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=3dce6601b495f5b3d45b59f7d2492a340ee7e84b5beca17e48f862502bd5603f
NEOTERM_PKG_DEPENDS="libiconv"
NEOTERM_PKG_BREAKS="yasm-dev"
NEOTERM_PKG_REPLACES="yasm-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--enable-nls"
