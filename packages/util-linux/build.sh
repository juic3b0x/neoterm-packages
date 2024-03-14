NEOTERM_PKG_HOMEPAGE=https://en.wikipedia.org/wiki/Util-linux
NEOTERM_PKG_DESCRIPTION="Miscellaneous system utilities"
NEOTERM_PKG_LICENSE="GPL-3.0, GPL-2.0, LGPL-2.1, BSD 3-Clause, BSD, ISC"
NEOTERM_PKG_LICENSE_FILE="\
Documentation/licenses/COPYING.GPL-3.0-or-later
Documentation/licenses/COPYING.GPL-2.0-or-later
Documentation/licenses/COPYING.LGPL-2.1-or-later
Documentation/licenses/COPYING.BSD-3-Clause
Documentation/licenses/COPYING.BSD-4-Clause-UC
Documentation/licenses/COPYING.ISC"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.39.3"
NEOTERM_PKG_REVISION=4
NEOTERM_PKG_SRCURL=https://www.kernel.org/pub/linux/utils/util-linux/v${NEOTERM_PKG_VERSION:0:4}/util-linux-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=7b6605e48d1a49f43cc4b4cfc59f313d0dd5402fa40b96810bd572e167dfed0f
# libcrypt is required for only newgrp and sulogin, which are not built anyways
NEOTERM_PKG_DEPENDS="libcap-ng, libsmartcols, ncurses, zlib"
NEOTERM_PKG_ESSENTIAL=true
NEOTERM_PKG_BREAKS="util-linux-dev"
NEOTERM_PKG_REPLACES="util-linux-dev"
# Most android kernels are built without namespace support, so remove lsns
NEOTERM_PKG_RM_AFTER_INSTALL="
bin/lsns
share/bash-completion/completions/lsns
share/man/man8/lsns.8.gz
"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_func_setns=yes
ac_cv_func_unshare=yes
ac_cv_func_uselocale=no
--enable-setpriv
--disable-agetty
--disable-ctrlaltdel
--disable-eject
--disable-fdformat
--disable-ipcmk
--disable-ipcrm
--disable-ipcs
--disable-kill
--disable-last
--disable-logger
--disable-mesg
--disable-makeinstall-chown
--disable-mountpoint
--disable-nologin
--disable-pivot_root
--disable-poman
--disable-raw
--disable-switch_root
--disable-wall
--disable-lsmem
--disable-chmem
--disable-rfkill
--disable-hwclock-cmos
"

neoterm_step_pre_configure() {
	if [ $NEOTERM_ARCH_BITS = 64 ]; then
		#prlimit() is only available in 64-bit bionic.
		NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_func_prlimit=yes"
	fi
}
