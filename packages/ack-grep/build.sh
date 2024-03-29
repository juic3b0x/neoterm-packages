NEOTERM_PKG_HOMEPAGE=https://beyondgrep.com/
NEOTERM_PKG_DESCRIPTION="Tool like grep optimized for programmers"
NEOTERM_PKG_LICENSE="Artistic-License-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.7.0
NEOTERM_PKG_SRCURL=https://beyondgrep.com/ack-v${NEOTERM_PKG_VERSION}
NEOTERM_PKG_SHA256=dd5a7c2df81ee15d97b6bf6b3ff84ad2529c98e1571817861c7d4fd8d48af908
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="perl"
NEOTERM_PKG_SKIP_SRC_EXTRACT=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true

neoterm_step_make_install() {
	neoterm_download \
		$NEOTERM_PKG_SRCURL \
		$NEOTERM_PREFIX/bin/ack \
		$NEOTERM_PKG_SHA256
	touch $NEOTERM_PREFIX/bin/ack
	chmod +x $NEOTERM_PREFIX/bin/ack
}
