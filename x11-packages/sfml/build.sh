NEOTERM_PKG_HOMEPAGE=https://www.sfml-dev.org/
NEOTERM_PKG_DESCRIPTION="A simple, fast, cross-platform and object-oriented multimedia API"
NEOTERM_PKG_LICENSE="ZLIB"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.6.1"
NEOTERM_PKG_SRCURL=https://github.com/SFML/SFML/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=82535db9e57105d4f3a8aedabd138631defaedc593cab589c924b7d7a11ffb9d
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="freetype, libc++, libflac, libogg, libvorbis, libx11, libxcursor, libxrandr, openal-soft, opengl"

neoterm_step_post_get_source() {
	cp src/SFML/Window/Android/JoystickImpl.{cpp,hpp} src/SFML/Window/Unix/

	find tools/pkg-config -name '*.pc.in' | xargs -n 1 \
		sed -i -E 's|^(libdir=)\$\{exec_prefix\}/(@CMAKE_INSTALL_LIBDIR@)$|\1\2|'
}
