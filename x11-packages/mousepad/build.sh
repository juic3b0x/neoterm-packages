NEOTERM_PKG_HOMEPAGE=https://gitlab.xfce.org/apps/mousepad
NEOTERM_PKG_DESCRIPTION="A simple text editor for the Xfce desktop environment"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
_MAJOR_VERSION=0.6
NEOTERM_PKG_VERSION=${_MAJOR_VERSION}.1
NEOTERM_PKG_SRCURL=https://archive.xfce.org/src/apps/mousepad/${_MAJOR_VERSION}/mousepad-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=560c5436c7bc7de33fbf3e9f6cc545280772ad898dfb73257d86533880ffff36
NEOTERM_PKG_DEPENDS="atk, gdk-pixbuf, glib, gtk3, gtksourceview4, harfbuzz, libcairo, libxfce4ui, libxfce4util, pango, xfconf, zlib"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--enable-gtksourceview4
"
