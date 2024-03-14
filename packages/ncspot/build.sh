NEOTERM_PKG_HOMEPAGE=https://github.com/hrkfdn/ncspot
NEOTERM_PKG_DESCRIPTION="An ncurses Spotify client written in Rust"
NEOTERM_PKG_LICENSE="BSD 2-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.0.0"
NEOTERM_PKG_SRCURL=https://github.com/hrkfdn/ncspot/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=516663b62b9536cb18e6d8eb69470a5b6560f2890e010e8a3d2e8cfc65df9497
NEOTERM_PKG_DEPENDS="dbus, pulseaudio"
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

NEOTERM_PKG_CONFLICTS="ncspot-mpris"

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--no-default-features
--features cursive/termion-backend,share_clipboard,pulseaudio_backend
"
# NOTE: ncurses-rs runs a test while building which fails while cross compiling:
# therefore, we use cursive/termion-backend instead.
