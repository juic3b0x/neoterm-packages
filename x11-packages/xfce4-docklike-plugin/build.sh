NEOTERM_PKG_HOMEPAGE=https://docs.xfce.org/panel-plugins/xfce4-docklike-plugin/start
NEOTERM_PKG_DESCRIPTION="A modern, docklike, minimalist taskbar for XFCE"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
_MAJOR_VERSION=0.4
NEOTERM_PKG_VERSION=${_MAJOR_VERSION}.1
NEOTERM_PKG_SRCURL=https://archive.xfce.org/src/panel-plugins/xfce4-docklike-plugin/${_MAJOR_VERSION}/xfce4-docklike-plugin-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=9da6eb18b4e755ee6affe5d36aa8af1892e5de811b0403d75a70480fe08d1b13
# exo is for bin/exo-desktop-item-edit.
NEOTERM_PKG_DEPENDS="atk, exo, gdk-pixbuf, glib, gtk3, harfbuzz, libc++, libcairo, libwnck, libx11, libxfce4ui, libxfce4util, libxi, pango, xfce4-panel, zlib"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_RM_AFTER_INSTALL="lib/locale"

neoterm_step_pre_configure () {
	LDFLAGS+=" -lXi"
	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
