NEOTERM_PKG_HOMEPAGE=https://www.tinc-vpn.org/
NEOTERM_PKG_DESCRIPTION="VPN daemon"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.0.36
NEOTERM_PKG_REVISION=5
NEOTERM_PKG_SRCURL=https://www.tinc-vpn.org/packages/tinc-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=40f73bb3facc480effe0e771442a706ff0488edea7a5f2505d4ccb2aa8163108
NEOTERM_PKG_DEPENDS="liblzo, openssl, zlib"

neoterm_step_pre_configure() {
	export LIBS="-llog"
}
