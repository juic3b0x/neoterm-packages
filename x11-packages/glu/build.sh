NEOTERM_PKG_HOMEPAGE=https://cgit.freedesktop.org/mesa/glu/
NEOTERM_PKG_DESCRIPTION="Mesa OpenGL Utility library"
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="LICENSE"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=9.0.3
NEOTERM_PKG_SRCURL=https://mesa.freedesktop.org/archive/glu/glu-$NEOTERM_PKG_VERSION.tar.xz
NEOTERM_PKG_SHA256=bd43fe12f374b1192eb15fe20e45ff456b9bc26ab57f0eee919f96ca0f8a330f
NEOTERM_PKG_DEPENDS="libc++, opengl"
NEOTERM_PKG_CONFLICTS="libglu"
NEOTERM_PKG_REPLACES="libglu"

neoterm_step_post_get_source() {
	cp "${NEOTERM_PKG_BUILDER_DIR}"/LICENSE ./
}

neoterm_step_pre_configure() {
	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
