NEOTERM_PKG_HOMEPAGE=https://gitlab.freedesktop.org/mstoeckl/waypipe
NEOTERM_PKG_DESCRIPTION="A proxy for Wayland clients"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.8.6
NEOTERM_PKG_SRCURL=https://gitlab.freedesktop.org/mstoeckl/waypipe/-/archive/v${NEOTERM_PKG_VERSION}/waypipe-v${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=da40de2e02d60c2c34d549e791a9019c1ddf9d79f42bfad0c6cb74f3f6af9b16
NEOTERM_PKG_DEPENDS="libandroid-spawn, liblz4, zstd"
NEOTERM_PKG_BUILD_DEPENDS="ffmpeg"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dwith_video=enabled
-Dwith_dmabuf=disabled
-Dwith_lz4=enabled
-Dwith_zstd=enabled
-Dwith_vaapi=disabled
-Dwith_systemtap=false
"

neoterm_step_pre_configure() {
	LDFLAGS+=" -landroid-spawn"
}
