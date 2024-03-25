NEOTERM_PKG_HOMEPAGE=https://www.ferzkopp.net/joomla/content/view/19/14/
NEOTERM_PKG_DESCRIPTION="Graphics primitives and surface functions for SDL2"
NEOTERM_PKG_LICENSE="ZLIB"
NEOTERM_PKG_LICENSE_FILE="COPYING"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.0.4
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://www.ferzkopp.net/Software/SDL2_gfx/SDL2_gfx-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=63e0e01addedc9df2f85b93a248f06e8a04affa014a835c2ea34bfe34e576262
NEOTERM_PKG_DEPENDS="sdl2"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-mmx
"

neoterm_step_pre_configure() {
	LDFLAGS+=" -lm"
}
