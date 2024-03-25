NEOTERM_PKG_HOMEPAGE=https://wiki.gnome.org/Projects/Libgee
NEOTERM_PKG_DESCRIPTION="A collection library providing GObject-based interfaces and classes for commonly used data structures"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
_MAJOR_VERSION=0.20
NEOTERM_PKG_VERSION=${_MAJOR_VERSION}.6
NEOTERM_PKG_SRCURL=https://ftp.gnome.org/pub/GNOME/sources/libgee/${_MAJOR_VERSION}/libgee-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=1bf834f5e10d60cc6124d74ed3c1dd38da646787fbf7872220b8b4068e476d4d
NEOTERM_PKG_DEPENDS="glib"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner, valac"
NEOTERM_PKG_DISABLE_GIR=false
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--enable-introspection=yes
"

neoterm_step_pre_configure() {
	neoterm_setup_gir
}
