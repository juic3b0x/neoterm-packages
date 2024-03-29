NEOTERM_PKG_HOMEPAGE=https://www.gnu.org.ua/software/gdbm/
NEOTERM_PKG_DESCRIPTION="Library of database functions that use extensible hashing"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.23
NEOTERM_PKG_SRCURL=https://mirrors.kernel.org/gnu/gdbm/gdbm-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=74b1081d21fff13ae4bd7c16e5d6e504a4c26f7cde1dca0d963a484174bbcacd
NEOTERM_PKG_DEPENDS="readline"
NEOTERM_PKG_BREAKS="gdbm-dev"
NEOTERM_PKG_REPLACES="gdbm-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--enable-libgdbm-compat"
