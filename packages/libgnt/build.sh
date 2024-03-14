NEOTERM_PKG_HOMEPAGE=https://keep.imfreedom.org/libgnt/libgnt
NEOTERM_PKG_DESCRIPTION="An ncurses toolkit for creating text-mode graphical user interfaces in a fast and easy way"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.14.3
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/project/pidgin/libgnt/${NEOTERM_PKG_VERSION}/libgnt-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=57f5457f72999d0bb1a139a37f2746ec1b5a02c094f2710a339d8bcea4236123
NEOTERM_PKG_DEPENDS="glib, libxml2, ncurses"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="-Ddoc=false -Dpython2=false"
