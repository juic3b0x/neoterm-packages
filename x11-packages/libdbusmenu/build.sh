NEOTERM_PKG_HOMEPAGE=https://launchpad.net/libdbusmenu
NEOTERM_PKG_DESCRIPTION="A small library designed to make sharing and displaying of menu structures over DBus"
NEOTERM_PKG_LICENSE="LGPL-2.1, LGPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
_MAJOR_VERSION=16.04
NEOTERM_PKG_VERSION=${_MAJOR_VERSION}.0
NEOTERM_PKG_SRCURL=https://launchpad.net/libdbusmenu/${_MAJOR_VERSION}/${NEOTERM_PKG_VERSION}/+download/libdbusmenu-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=b9cc4a2acd74509435892823607d966d424bd9ad5d0b00938f27240a1bfa878a
NEOTERM_PKG_DEPENDS="glib, json-glib"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner, valac"
NEOTERM_PKG_DISABLE_GIR=false
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-dumper
--enable-introspection=yes
--enable-vala=yes
"

neoterm_step_pre_configure() {
	neoterm_setup_gir
}
