NEOTERM_PKG_HOMEPAGE=https://lxqt.github.io
NEOTERM_PKG_DESCRIPTION="Tools to set global keyboard shortcuts in LXQt sessions"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="Simeon Huang <symeon@librehat.com>"
NEOTERM_PKG_VERSION="1.4.0"
NEOTERM_PKG_SRCURL="https://github.com/lxqt/lxqt-globalkeys/releases/download/${NEOTERM_PKG_VERSION}/lxqt-globalkeys-${NEOTERM_PKG_VERSION}.tar.xz"
NEOTERM_PKG_SHA256=ffed3e299d11b3b6298bf5558cff9ba2b979d6d7a5cad72af0ae640a991b6203
NEOTERM_PKG_DEPENDS="libc++, qt5-qtbase, kwindowsystem, liblxqt, libx11"
NEOTERM_PKG_BUILD_DEPENDS="lxqt-build-tools, qt5-qtbase-cross-tools, qt5-qttools-cross-tools"
NEOTERM_PKG_AUTO_UPDATE=true

