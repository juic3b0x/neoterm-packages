NEOTERM_PKG_HOMEPAGE=https://dbus.freedesktop.org/doc/dbus-python/
NEOTERM_PKG_DESCRIPTION="Python bindings for D-Bus"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.3.2
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://dbus.freedesktop.org/releases/dbus-python/dbus-python-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=ad67819308618b5069537be237f8e68ca1c7fcc95ee4a121fe6845b1418248f8
NEOTERM_PKG_DEPENDS="dbus, glib, python"
NEOTERM_PKG_PYTHON_COMMON_DEPS="wheel"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dpython=python
"

neoterm_step_pre_configure() {
	# Force using Meson
	rm -f configure
}
