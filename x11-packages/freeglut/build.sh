NEOTERM_PKG_HOMEPAGE=https://freeglut.sourceforge.net/
NEOTERM_PKG_DESCRIPTION="Provides functionality for small OpenGL programs"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.4.0
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/freeglut/freeglut-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=3c0bcb915d9b180a97edaebd011b7a1de54583a838644dcd42bb0ea0c6f3eaec
NEOTERM_PKG_DEPENDS="glu, libx11, libxi, libxrandr, opengl"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DANDROID_NO_NEOTERM=OFF
"

neoterm_step_post_get_source() {
	sed -i CMakeLists.txt \
		-e 's/\([^A-Za-z0-9_]ANDROID\)\([^A-Za-z0-9_]\)/\1_NO_NEOTERM\2/g' \
		-e 's/\([^A-Za-z0-9_]ANDROID\)$/\1_NO_NEOTERM/g'
}
