NEOTERM_PKG_HOMEPAGE=https://i3wm.org/i3status/
NEOTERM_PKG_DESCRIPTION="Generates status bar to use with i3bar"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.14
NEOTERM_PKG_SRCURL=https://i3wm.org/i3status/i3status-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=5c4d0273410f9fa3301fd32065deda32e9617fcae8b3cb34793061bf21644924
NEOTERM_PKG_DEPENDS="libandroid-glob, libconfuse, libnl, pulseaudio, yajl"
NEOTERM_PKG_CONFFILES="etc/i3status.conf"

neoterm_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
}
