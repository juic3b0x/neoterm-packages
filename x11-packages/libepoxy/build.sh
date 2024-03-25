NEOTERM_PKG_HOMEPAGE=https://github.com/anholt/libepoxy
NEOTERM_PKG_DESCRIPTION="Library handling OpenGL function pointer management"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.5.10
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/anholt/libepoxy/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=a7ced37f4102b745ac86d6a70a9da399cc139ff168ba6b8002b4d8d43c900c15
NEOTERM_PKG_DEPENDS="opengl"

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dglx=yes
-Degl=yes
-Dx11=true
-Dtests=false
"
