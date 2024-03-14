NEOTERM_PKG_HOMEPAGE=https://github.com/tatsuhiro-t/wslay
NEOTERM_PKG_DESCRIPTION="WebSocket library"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.1.1
NEOTERM_PKG_SRCURL=https://github.com/tatsuhiro-t/wslay/releases/download/release-$NEOTERM_PKG_VERSION/wslay-$NEOTERM_PKG_VERSION.tar.bz2
NEOTERM_PKG_SHA256=6a3e2ceba52424b14521a7469a35bfd781b018ca93c300b71df3618273af6ed9
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP='(?<=-).+'
NEOTERM_PKG_PROVIDES="wslay"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-static
"

neoterm_step_pre_configure() {
	autoreconf -fi
}

neoterm_step_post_massage() {
	find lib -name '*.la' -delete
}
