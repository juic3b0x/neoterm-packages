NEOTERM_PKG_HOMEPAGE=https://wiki.gnome.org/Accessibility
NEOTERM_PKG_DESCRIPTION="A python client library for the AT-SPI D-Bus accessibility infrastructure"
NEOTERM_PKG_LICENSE="LGPL-2.0, GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
_MAJOR_VERSION=2.46
NEOTERM_PKG_VERSION=${_MAJOR_VERSION}.0
NEOTERM_PKG_SRCURL=https://download.gnome.org/sources/pyatspi/${_MAJOR_VERSION}/pyatspi-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=d45489cf3d47aa150b1a35e8949b3b31035f8c2075e588d26b6efc625970c62e
NEOTERM_PKG_DEPENDS="at-spi2-core, dbus, dbus-python, pygobject, python"
NEOTERM_PKG_SETUP_PYTHON=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
