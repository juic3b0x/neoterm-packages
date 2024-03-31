NEOTERM_PKG_HOMEPAGE=https://github.com/any1/wayvnc
NEOTERM_PKG_DESCRIPTION="A VNC server for wlroots based Wayland compositors"
NEOTERM_PKG_LICENSE="ISC"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.8.0"
NEOTERM_PKG_SRCURL=https://github.com/any1/wayvnc/archive/refs/tags/v${NEOTERM_PKG_VERSION[0]}.tar.gz
NEOTERM_PKG_SHA256=075dcbe321d51ee5e6b59467f2d2fa313d49254fe574f9d6caf400f3a2ffd368
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libaml, libdrm, libjansson, libneatvnc, libpixman, libwayland, libxkbcommon"
NEOTERM_PKG_BUILD_DEPENDS="libwayland-protocols"
NEOTERM_PKG_SUGGESTS="sway"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dscreencopy-dmabuf=disabled
-Dpam=disabled
"
