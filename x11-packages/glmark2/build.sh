NEOTERM_PKG_HOMEPAGE=https://github.com/glmark2/glmark2
NEOTERM_PKG_DESCRIPTION="glmark2 is an OpenGL 2.0 and ES 2.0 benchmark"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2023.01
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://github.com/glmark2/glmark2/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=8fece3fc323b643644a525be163dc4931a4189971eda1de8ad4c1712c5db3d67
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_DEPENDS="libjpeg-turbo, libx11, opengl, libpng, libjpeg-turbo"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dflavors=x11-gl,x11-glesv2,x11-gl-egl
"
