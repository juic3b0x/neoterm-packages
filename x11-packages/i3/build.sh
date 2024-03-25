NEOTERM_PKG_HOMEPAGE=https://i3wm.org/
NEOTERM_PKG_DESCRIPTION="An improved dynamic tiling window manager"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="4.23"
NEOTERM_PKG_SRCURL=https://i3wm.org/downloads/i3-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=61026a7196c9139d0f3aadd27197e8b320c576e3a450e01d74c1aca484044c46
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="glib, libandroid-glob, libandroid-wordexp, libcairo, libev, libiconv, libxcb, libxkbcommon, pango, pcre2, perl, startup-notification, xcb-util, xcb-util-cursor, xcb-util-keysyms, xcb-util-wm, xcb-util-xrm, yajl"
NEOTERM_PKG_RECOMMENDS="i3status"

NEOTERM_PKG_CONFFILES="
i3/config
i3/config.keycodes
"

neoterm_step_pre_configure() {
	LDFLAGS+=" -landroid-glob -landroid-wordexp"
}
