NEOTERM_PKG_HOMEPAGE=https://quassel-irc.org/
NEOTERM_PKG_DESCRIPTION="Quassel IRC is a modern, cross-platform, distributed IRC client"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.14.0
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/quassel/quassel/releases/download/$NEOTERM_PKG_VERSION/quassel-$NEOTERM_PKG_VERSION.tar.xz
NEOTERM_PKG_SHA256=090777f37a6ae1057a046d5c2896ce5e4bef2382377e3ba52c63efe6b5fe4e10
NEOTERM_PKG_DEPENDS="boost, dbus, qt5-qtbase, qt5-qtsvg, qt5-qtx11extras, qt5-qtmultimedia, qt5-qtwebengine, libdbusmenu-qt, libnotify, sqlite, zlib"
NEOTERM_PKG_BUILD_DEPENDS="boost-headers, qt5-qtbase-cross-tools, qt5-qttools-cross-tools"
