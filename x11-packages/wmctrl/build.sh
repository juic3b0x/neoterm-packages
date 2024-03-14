NEOTERM_PKG_HOMEPAGE=https://sites.google.com/site/tstyblo/wmctrl/
NEOTERM_PKG_DESCRIPTION="A UNIX/Linux command line tool to interact with an EWMH/NetWM compatible X Window Manager"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.07
NEOTERM_PKG_SRCURL=https://sites.google.com/site/tstyblo/wmctrl/wmctrl-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=d78a1efdb62f18674298ad039c5cbdb1edb6e8e149bb3a8e3a01a4750aa3cca9
NEOTERM_PKG_DEPENDS="glib, libx11, libxmu"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--mandir=$NEOTERM_PREFIX/share/man
"
