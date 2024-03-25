NEOTERM_PKG_HOMEPAGE=https://www.gnu.org/software/mtools/
NEOTERM_PKG_DESCRIPTION="Tool for manipulating FAT images"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=4.0.43
NEOTERM_PKG_SRCURL=https://mirrors.kernel.org/gnu/mtools/mtools-${NEOTERM_PKG_VERSION}.tar.lz
NEOTERM_PKG_SHA256=997ffe4125a19de1fd433ed63f128f7d54bc1a5915f3cdb36da6491ef917f217
NEOTERM_PKG_DEPENDS="libandroid-support, libiconv"

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-floppyd
ac_cv_lib_bsd_main=no
"

neoterm_step_pre_configure() {
	export LIBS="-liconv"
}
