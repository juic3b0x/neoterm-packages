NEOTERM_PKG_HOMEPAGE=https://www.gnome.org/
NEOTERM_PKG_DESCRIPTION="GNOME desktop schemas contains a collection of GSettings schemas for settings shared by various components of a desktop."
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="Yisus7u7 <dev.yisus@hotmail.com>"
NEOTERM_PKG_VERSION="45.0"
NEOTERM_PKG_SRCURL=https://download.gnome.org/sources/gsettings-desktop-schemas/${NEOTERM_PKG_VERSION%.*}/gsettings-desktop-schemas-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=365c8d04daf79b38c8b3dc9626349a024f9e4befdd31fede74b42f7a9fbe0ae2
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_RECOMMENDS="dconf"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner"
NEOTERM_PKG_DISABLE_GIR=false
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dintrospection=true
"
NEOTERM_PKG_PLATFORM_INDEPENDENT=true

neoterm_step_pre_configure() {
	neoterm_setup_gir
}
