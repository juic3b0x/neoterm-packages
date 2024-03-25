NEOTERM_PKG_HOMEPAGE=https://www.alsa-project.org
NEOTERM_PKG_DESCRIPTION="ALSA utilities"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.1.3
NEOTERM_PKG_SRCURL=https://alsa-project.org/files/pub/utils/alsa-utils-$NEOTERM_PKG_VERSION.tar.bz2
NEOTERM_PKG_SHA256=127217a54eea0f9a49700a2f239a2d4f5384aa094d68df04a8eb80132eb6167c
NEOTERM_PKG_DEPENDS="ncurses"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--with-udev-rules-dir=$NEOTERM_PREFIX/lib/udev/rules.d --with-asound-state-dir=$NEOTERM_PREFIX/var/lib/alsa --disable-bat --disable-rst2man"

neoterm_step_pre_configure() {
    LDFLAGS+=" -llog"
}
