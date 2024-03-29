NEOTERM_PKG_HOMEPAGE=https://github.com/PCMan/gtk3-nocsd
NEOTERM_PKG_DESCRIPTION="A small module used to disable the client side decoration of Gtk+ 3"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3
NEOTERM_PKG_SRCURL=https://github.com/PCMan/gtk3-nocsd/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=779c47d894ee3b6751ddb02b62a76757b77eb81232c4f9335564654817889570
NEOTERM_PKG_BUILD_DEPENDS="gobject-introspection, gtk3"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="prefix=$NEOTERM_PREFIX"
