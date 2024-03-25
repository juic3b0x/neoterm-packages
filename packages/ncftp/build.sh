NEOTERM_PKG_HOMEPAGE=https://www.ncftp.com/
NEOTERM_PKG_DESCRIPTION="A free set of programs that use the File Transfer Protocol"
# License: Clarified Artistic
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="doc/LICENSE.txt"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.2.6
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://www.ncftp.com/downloads/ncftp/ncftp-${NEOTERM_PKG_VERSION}-src.tar.xz
NEOTERM_PKG_SHA256=5f200687c05d0807690d9fb770327b226f02dd86155b49e750853fce4e31098d
NEOTERM_PKG_DEPENDS="ncurses, resolv-conf"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	autoreconf -fi -Iautoconf_local

	CFLAGS+=" -fcommon"

	export ac_cv_path_TAR=$NEOTERM_PREFIX/bin/tar
}
