NEOTERM_PKG_HOMEPAGE=https://gitlab.com/psmisc/psmisc
NEOTERM_PKG_DESCRIPTION="Some small useful utilities that use the proc filesystem"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=23.6
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://fossies.org/linux/misc/psmisc-$NEOTERM_PKG_VERSION.tar.xz
NEOTERM_PKG_SHA256=257dde06159a4c49223d06f1cccbeb68933a4514fc8f1d77c64b54f0d108822a
NEOTERM_PKG_DEPENDS="ncurses"
NEOTERM_PKG_ESSENTIAL=true
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_RM_AFTER_INSTALL="bin/pstree.x11"
