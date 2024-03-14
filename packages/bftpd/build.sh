NEOTERM_PKG_HOMEPAGE=https://bftpd.sourceforge.net/
NEOTERM_PKG_DESCRIPTION="Small, easy-to-configure FTP server"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="6.2"
NEOTERM_PKG_SRCURL=https://kumisystems.dl.sourceforge.net/project/bftpd/bftpd/bftpd-${NEOTERM_PKG_VERSION}/bftpd-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=959185b1457a2cd8e404d52957d51879d56dd72b75a93049528af11ade00a6c2
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libcrypt"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--mandir=$NEOTERM_PREFIX/share/man
"

NEOTERM_PKG_CONFFILES="etc/bftpd.conf"
NEOTERM_PKG_RM_AFTER_INSTALL="var/log/bftpd.log"

neoterm_step_pre_configure() {
	CFLAGS+=" -fcommon"
}
