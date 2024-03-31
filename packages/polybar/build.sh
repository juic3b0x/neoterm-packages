NEOTERM_PKG_HOMEPAGE=https://polybar.github.io
NEOTERM_PKG_DESCRIPTION="A fast and easy-to-use status bar"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="Tristan Ross <spaceboyross@yandex.com>"
NEOTERM_PKG_VERSION=3.6.3
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL="https://github.com/polybar/polybar/releases/download/${NEOTERM_PKG_VERSION}/polybar-${NEOTERM_PKG_VERSION}.tar.gz"
NEOTERM_PKG_SHA256=f25758573567208fc7b6f4d4115a6117a87389cbcc094cf605d079775be95fa5
NEOTERM_PKG_DEPENDS="fontconfig, freetype, jsoncpp, libandroid-glob, libc++, libcairo, libcurl, libnl, libuv, libxcb, pulseaudio, xcb-util-cursor, xcb-util-image, xcb-util-wm, xcb-util-xrm"
NEOTERM_PKG_BUILD_DEPENDS="i3"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="-DENABLE_I3=ON"

neoterm_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
}
