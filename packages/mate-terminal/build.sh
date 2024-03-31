NEOTERM_PKG_HOMEPAGE=https://mate-terminal.mate-desktop.dev/
NEOTERM_PKG_DESCRIPTION="This is the MATE terminal emulator application"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.28.1"
NEOTERM_PKG_SRCURL=https://github.com/mate-desktop/mate-terminal/releases/download/v$NEOTERM_PKG_VERSION/mate-terminal-$NEOTERM_PKG_VERSION.tar.xz
NEOTERM_PKG_SHA256=f135eb1a9e2ae22798ecb2dc1914fdb4cfd774e6bb65c0152be37cc6c9469e92
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libvte, dconf, gtk3, libsm, mate-desktop"

neoterm_step_pre_configure() {
	autoreconf -vfi
}
