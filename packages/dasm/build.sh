NEOTERM_PKG_HOMEPAGE=https://dasm-dillon.sourceforge.io/
NEOTERM_PKG_DESCRIPTION="Macro assembler with support for several 8-bit microprocessors"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.20.14.1
NEOTERM_PKG_SRCURL=https://github.com/dasm-assembler/dasm/archive/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=ec71ffd10eeaa70bf7587ee0d79a92cd3f0a017c0d6d793e37d10359ceea663a
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make_install() {
	cp $NEOTERM_PKG_SRCDIR/bin/* $NEOTERM_PREFIX/bin/
}
