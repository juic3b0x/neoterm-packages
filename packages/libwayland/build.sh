NEOTERM_PKG_HOMEPAGE=https://wayland.freedesktop.org/
NEOTERM_PKG_DESCRIPTION="Wayland protocol library"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.22.0
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://gitlab.freedesktop.org/wayland/wayland/-/releases/${NEOTERM_PKG_VERSION}/downloads/wayland-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=1540af1ea698a471c2d8e9d288332c7e0fd360c8f1d12936ebb7e7cbc2425842
NEOTERM_PKG_DEPENDS="libandroid-support, libexpat, libffi, libxml2"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Ddocumentation=false
-Dtests=false
"
NEOTERM_PKG_HOSTBUILD=true
NEOTERM_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS="
-Ddocumentation=false
-Ddtd_validation=false
-Dlibraries=false
-Dtests=false
--prefix ${NEOTERM_PREFIX}/opt/${NEOTERM_PKG_NAME}/cross
"

neoterm_step_host_build() {
	# XXX: neoterm_setup_meson is not expected to be called in host build
	AR=;CC=;CFLAGS=;CPPFLAGS=;CXX=;CXXFLAGS=;LD=;LDFLAGS=;PKG_CONFIG=;STRIP=
	neoterm_setup_meson
	unset AR CC CFLAGS CPPFLAGS CXX CXXFLAGS LD LDFLAGS PKG_CONFIG STRIP

	${NEOTERM_MESON} ${NEOTERM_PKG_SRCDIR} . \
		${NEOTERM_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS}
	ninja -j "${NEOTERM_MAKE_PROCESSES}" install
}

neoterm_step_pre_configure() {
	export PATH="$NEOTERM_PREFIX/opt/$NEOTERM_PKG_NAME/cross/bin:$PATH"
}
