NEOTERM_PKG_HOMEPAGE=https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/keyutils.git
NEOTERM_PKG_DESCRIPTION="Utilities to control the kernel key management facility"
NEOTERM_PKG_LICENSE="GPL-2.0, LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.6.3
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/keyutils.git/snapshot/keyutils-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=a61d5706136ae4c05bd48f86186bcfdbd88dd8bd5107e3e195c924cfc1b39bb4
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	CPPFLAGS+=" -Dindex=strchr -Drindex=strrchr"
}
