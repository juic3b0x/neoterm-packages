NEOTERM_PKG_HOMEPAGE=https://github.com/mdbtools/mdbtools
NEOTERM_PKG_DESCRIPTION="A set of programs to help you extract data from Microsoft Access files in various settings"
NEOTERM_PKG_LICENSE="GPL-2.0, LGPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.0.0
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://github.com/mdbtools/mdbtools/releases/download/v${NEOTERM_PKG_VERSION}/mdbtools-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=3446e1d71abdeb98d41e252777e67e1909b186496fda59f98f67032f7fbcd955
NEOTERM_PKG_DEPENDS="glib, libiconv, readline, libiodbc"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--with-iodbc=$NEOTERM_PREFIX"
