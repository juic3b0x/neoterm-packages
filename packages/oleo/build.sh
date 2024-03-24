TERMUX_PKG_HOMEPAGE=https://www.gnu.org/software/oleo/
TERMUX_PKG_DESCRIPTION="The GNU Spreadsheet"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@neoterm"
TERMUX_PKG_VERSION=1.99.16
TERMUX_PKG_REVISION=7
TERMUX_PKG_SRCURL=http://ftp.gnu.org/gnu/oleo/oleo-$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=6598df85d06ff2534ec08ed0657508f17dbbc58dd02d419160989de7c487bc86
TERMUX_PKG_DEPENDS="ncurses"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--without-x --infodir=$TERMUX_PREFIX/share/info"
TERMUX_PKG_KEEP_INFOPAGES=true

TERMUX_PKG_RM_AFTER_INSTALL="
Oleo/*
share/oleo/oleo.html"

termux_step_pre_configure() {
	export CFLAGS+=" -fcommon"
}
