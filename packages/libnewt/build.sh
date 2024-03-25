NEOTERM_PKG_HOMEPAGE=https://pagure.io/newt
NEOTERM_PKG_DESCRIPTION="A programming library for color text mode, widget based user interfaces"
NEOTERM_PKG_LICENSE="LGPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.52.24"
NEOTERM_PKG_SRCURL=https://releases.pagure.org/newt/newt-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=5ded7e221f85f642521c49b1826c8de19845aa372baf5d630a51774b544fbdbb
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libandroid-support, slang"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-nls
--without-python
--without-tcl
"
