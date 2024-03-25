NEOTERM_PKG_HOMEPAGE=https://pygobject.readthedocs.io/
NEOTERM_PKG_DESCRIPTION="Python package which provides bindings for GObject based libraries"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
_MAJOR_VERSION=3.44
NEOTERM_PKG_VERSION=${_MAJOR_VERSION}.1
NEOTERM_PKG_SRCURL=https://download.gnome.org/sources/pygobject/${_MAJOR_VERSION}/pygobject-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=3c6805d1321be90cc32e648215a562430e0d3d6edcda8f4c5e7a9daffcad5710
NEOTERM_PKG_DEPENDS="glib, gobject-introspection, libcairo, libffi, pycairo, python"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner"
NEOTERM_PKG_PYTHON_COMMON_DEPS="wheel"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dpycairo=enabled
-Dtests=false
"

neoterm_step_pre_configure() {
	neoterm_setup_gir
}
