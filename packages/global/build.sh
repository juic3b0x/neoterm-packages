NEOTERM_PKG_HOMEPAGE=https://www.gnu.org/software/global/
NEOTERM_PKG_DESCRIPTION="Source code search and browse tools"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="6.6.12"
NEOTERM_PKG_SRCURL=https://mirrors.kernel.org/gnu/global/global-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=542a5b06840e14eca548b4bb60b44c0adcf01024e68eb362f8bf716007885901
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_posix1_2008_realpath=yes
--with-posix-sort=$NEOTERM_PREFIX/bin/sort
--with-ncurses=$NEOTERM_PREFIX
"
# coreutils provides the posix sort executable:
NEOTERM_PKG_DEPENDS="coreutils, ncurses, libltdl"
