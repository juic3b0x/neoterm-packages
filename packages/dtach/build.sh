NEOTERM_PKG_HOMEPAGE=https://dtach.sourceforge.net/
NEOTERM_PKG_DESCRIPTION="Emulates the detach feature of screen"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.9
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/sourceforge/dtach/dtach-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=32e9fd6923c553c443fab4ec9c1f95d83fa47b771e6e1dafb018c567291492f3

neoterm_step_make_install() {
	install -Dm700 -t ${NEOTERM_PREFIX}/bin dtach
	install -Dm600 -t ${NEOTERM_PREFIX}/share/man/man1 ${NEOTERM_PKG_SRCDIR}/dtach.1
}
