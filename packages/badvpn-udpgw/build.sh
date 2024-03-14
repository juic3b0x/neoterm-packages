NEOTERM_PKG_HOMEPAGE=https://github.com/ambrop72/badvpn
NEOTERM_PKG_DESCRIPTION="UDP gateway for BadVPN"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.999.130
NEOTERM_PKG_SRCURL=https://github.com/ambrop72/badvpn/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=bfd4bbfebd7274bcec792558c9a2fd60e39cd92e04673825ade5d04154766109

neoterm_step_configure() {
	:
}

neoterm_step_make() {
	SRCDIR="$NEOTERM_PKG_SRCDIR" ENDIAN=little KERNEL=2.4 \
		bash "$NEOTERM_PKG_SRCDIR/compile-udpgw.sh"
}

neoterm_step_make_install() {
	install -Dm700 -T udpgw $NEOTERM_PREFIX/bin/badvpn-udpgw
}
