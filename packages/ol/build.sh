NEOTERM_PKG_HOMEPAGE=https://yuriy-chumak.github.io/ol/
NEOTERM_PKG_DESCRIPTION="Purely functional dialect of Lisp"
NEOTERM_PKG_LICENSE="LGPL-3.0, MIT"
NEOTERM_PKG_MAINTAINER="Yuriy Chumak <yuriy.chumak@mail.com>"
NEOTERM_PKG_VERSION=2.4
NEOTERM_PKG_SRCURL=https://github.com/yuriy-chumak/ol/archive/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=019978ddcf0befc8b8de9f50899c9dd0f47a3e18cf9556bc72a75ae2d1d965d4
NEOTERM_PKG_BUILD_DEPENDS="vim"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="PREFIX=$NEOTERM_PREFIX"
