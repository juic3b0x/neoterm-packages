NEOTERM_PKG_HOMEPAGE=https://github.com/swaywm/sway
NEOTERM_PKG_DESCRIPTION="i3-compatible Wayland compositor"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.8.1"
NEOTERM_PKG_SRCURL=https://github.com/swaywm/sway/releases/download/$NEOTERM_PKG_VERSION/sway-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=73f08fd2cf7948e8af900709efe44eae412ae11c5773960e25c9aa09f73bad41
NEOTERM_PKG_DEPENDS="gdk-pixbuf, json-c, libandroid-wordexp, libcairo, libevdev, libwayland, pango, pcre2, wlroots"
NEOTERM_PKG_BUILD_DEPENDS="libwayland-protocols"
NEOTERM_PKG_RECOMMENDS="xwayland"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dxwayland=enabled
"

neoterm_step_pre_configure() {
	export PATH="$NEOTERM_PREFIX/opt/libwayland/cross/bin:$PATH"

	# XXX: use alloca for shm_open
	export CPPFLAGS+=" -Wno-alloca"
    export LDFLAGS+=" -landroid-wordexp"
}
