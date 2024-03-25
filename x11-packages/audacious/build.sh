NEOTERM_PKG_HOMEPAGE=https://audacious-media-player.org
NEOTERM_PKG_DESCRIPTION="An advanced audio player"
NEOTERM_PKG_LICENSE="BSD 2-Clause"
NEOTERM_PKG_MAINTAINER="Simeon Huang <symeon@librehat.com>"
NEOTERM_PKG_VERSION=4.3.1
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_SRCURL=https://distfiles.audacious-media-player.org/audacious-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=85e9e26841505b51e342ee72a2d05f19bef894f567a029ebb3f3e0c1adb42042
NEOTERM_PKG_DEPENDS="libc++, qt5-qtbase, dbus-glib"
NEOTERM_PKG_BUILD_DEPENDS="qt5-qtbase-cross-tools"
NEOTERM_PKG_RECOMMENDS="audacious-plugins"
# Audacious out-of-source build doesn't seem to work
NEOTERM_PKG_BUILD_IN_SRC=true
# Audacious has switched to Qt toolkit and it's the default GUI option now
# Disable GTK to reduce the size and dependencies
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--enable-qt --disable-gtk"
