NEOTERM_PKG_HOMEPAGE=https://gitlab.freedesktop.org/wayland/weston
NEOTERM_PKG_DESCRIPTION="Reference implementation of a wayland compositor"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="13.0.0"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://gitlab.freedesktop.org/wayland/weston/-/archive/${NEOTERM_PKG_VERSION}/weston-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=a4848b7cc510e3e88c9f2fcc808fd44c51fae622f13242f801a7c5107983335c
NEOTERM_PKG_DEPENDS="freerdp, libaml, libandroid-shmem, libcairo, libcairo, libevdev, libglvnd, libneatvnc, libseat, libwayland, libwebp, libxcb, libxcursor, libxkbcommon, littlecms, pango, xcb-util-cursor"
NEOTERM_PKG_BUILD_DEPENDS="libwayland-cross-scanner, libwayland-protocols"
# XXX: Do not depend on gbm
NEOTERM_PKG_ANTI_BUILD_DEPENDS="mesa"
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dbackend-drm=false
-Dbackend-drm-screencast-vaapi=false
-Dremoting=false
-Dpipewire=false
-Drenderer-gl=true
-Dbackend-pipewire=false
-Dbackend-default=headless
-Dxwayland-path=$NEOTERM_PREFIX/bin/Xwayland
-Dsystemd=false
-Dsimple-clients=damage,shm,touch
-Ddemo-clients=false
"

neoterm_step_pre_configure() {
	export PATH="$NEOTERM_PREFIX/opt/libwayland/cross/bin:$PATH"

	export LDFLAGS+=" -landroid-shmem"
}
