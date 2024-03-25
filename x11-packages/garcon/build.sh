NEOTERM_PKG_HOMEPAGE=https://www.xfce.org/
NEOTERM_PKG_DESCRIPTION="Implementation of the freedesktop.org menu specification"
NEOTERM_PKG_LICENSE="LGPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
_MAJOR_VERSION=4.18
NEOTERM_PKG_VERSION=${_MAJOR_VERSION}.1
NEOTERM_PKG_SRCURL=https://archive.xfce.org/src/xfce/garcon/${_MAJOR_VERSION}/garcon-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=fe7a932a6dac95eb1438f3fbfd53096756ff2e1cb179d10d0fb796cefbb4c20b
NEOTERM_PKG_DEPENDS="atk, gdk-pixbuf, glib, gtk3, harfbuzz, libcairo, libxfce4ui, libxfce4util, pango, zlib"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner"
NEOTERM_PKG_CONFLICTS="libgarcon"
NEOTERM_PKG_REPLACES="libgarcon"
NEOTERM_PKG_PROVIDES="libgarcon"
NEOTERM_PKG_DISABLE_GIR=false
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--enable-introspection=yes
"

neoterm_step_pre_configure() {
	neoterm_setup_gir
}
