NEOTERM_PKG_HOMEPAGE=https://gitlab.freedesktop.org/wlroots/wlroots
NEOTERM_PKG_DESCRIPTION="Modular wayland compositor library"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.16.2"
NEOTERM_PKG_SRCURL=https://gitlab.freedesktop.org/wlroots/wlroots/-/archive/${NEOTERM_PKG_VERSION}/wlroots-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=afea2cc740344c4e86749cf4908e07692e183cb14a3db854d24dec454c664b88
NEOTERM_PKG_DEPENDS="libdrm, libglvnd, libpixman, libwayland, libxcb, libxkbcommon, xcb-util-renderutil, xcb-util-wm"
NEOTERM_PKG_BUILD_DEPENDS="libglvnd-dev, libwayland-cross-scanner, libwayland-protocols, xwayland"
NEOTERM_PKG_RECOMMENDS="xwayland"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dexamples=false
-Dxwayland=enabled
-Dsession=disabled
-Dbackends=x11
-Drenderers=gles2
"

neoterm_step_pre_configure() {
	export PATH="$NEOTERM_PREFIX/opt/libwayland/cross/bin:$PATH"

	# XXX: use alloca for shm_open
	export CPPFLAGS+=" -Wno-alloca"
}
