NEOTERM_PKG_HOMEPAGE=https://github.com/yshui/picom
NEOTERM_PKG_DESCRIPTION="A lightweight compositor for X11"
NEOTERM_PKG_LICENSE="MIT, MPL-2.0"
NEOTERM_PKG_LICENSE_FILE="COPYING, LICENSES/MIT, LICENSES/MPL-2.0"
NEOTERM_PKG_MAINTAINER="Rafael Kitover <rkitover@gmail.com>"
NEOTERM_PKG_VERSION=10.2
NEOTERM_PKG_SRCURL=https://github.com/yshui/picom/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=9741577df0136d8a2be48005ca2b93edc15913528e19bceb798535ca4683341c
NEOTERM_PKG_DEPENDS="dbus, libconfig, libev, libpixman, libx11, libxcb, opengl, pcre, xcb-util-image, xcb-util-renderutil"
NEOTERM_PKG_BUILD_DEPENDS="uthash, xorgproto"

neoterm_step_pre_configure() {
	sed -i "s/^\(host_system *= *\).*/\1'linux'/" src/meson.build
}
