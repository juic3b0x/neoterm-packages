NEOTERM_PKG_HOMEPAGE=https://www.gnu.org/software/indent/
NEOTERM_PKG_DESCRIPTION="C language source code formatting program"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.2.13
NEOTERM_PKG_SRCURL=https://mirrors.kernel.org/gnu/indent/indent-$NEOTERM_PKG_VERSION.tar.xz
NEOTERM_PKG_SHA256=1b81ba4e9a006ca8e6eb5cbbe4cf4f75dfc1fc9301b459aa0d40393e85590a0b
NEOTERM_PKG_DEPENDS="libandroid-support"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_func_setlocale=no"
NEOTERM_PKG_RM_AFTER_INSTALL="bin/texinfo2man"
