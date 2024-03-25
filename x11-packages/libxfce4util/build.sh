NEOTERM_PKG_HOMEPAGE=https://www.xfce.org/
NEOTERM_PKG_DESCRIPTION="Basic utility non-GUI functions for XFCE"
NEOTERM_PKG_LICENSE="LGPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
_MAJOR_VERSION=4.18
NEOTERM_PKG_VERSION=${_MAJOR_VERSION}.1
NEOTERM_PKG_SRCURL=https://archive.xfce.org/src/xfce/libxfce4util/${_MAJOR_VERSION}/libxfce4util-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=8a52063a5adc66252238cad9ee6997909b59983ed21c77eb83c5e67829d1b01f
NEOTERM_PKG_DEPENDS="glib"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner"
NEOTERM_PKG_DISABLE_GIR=false
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--enable-introspection=yes
--enable-vala=no
--enable-gtk-doc-html=no
"

neoterm_step_pre_configure() {
	neoterm_setup_gir
}
