NEOTERM_PKG_HOMEPAGE=https://www.freedesktop.org/wiki/Software/libevdev/
NEOTERM_PKG_DESCRIPTION="Wrapper library for evdev devices"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.13.1
NEOTERM_PKG_SRCURL=https://www.freedesktop.org/software/libevdev/libevdev-$NEOTERM_PKG_VERSION.tar.xz
NEOTERM_PKG_SHA256=06a77bf2ac5c993305882bc1641017f5bec1592d6d1b64787bad492ab34f2f36
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--disable-test-run"
NEOTERM_PKG_RM_AFTER_INSTALL="
share/man/man1/
"

neoterm_step_pre_configure() {
	autoreconf -i
}
