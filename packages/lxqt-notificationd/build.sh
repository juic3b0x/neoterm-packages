NEOTERM_PKG_HOMEPAGE=https://lxqt.github.io
NEOTERM_PKG_DESCRIPTION="The LXQt notification daemon"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="Simeon Huang <symeon@librehat.com>"
NEOTERM_PKG_VERSION="1.4.0"
NEOTERM_PKG_SRCURL="https://github.com/lxqt/lxqt-notificationd/releases/download/${NEOTERM_PKG_VERSION}/lxqt-notificationd-${NEOTERM_PKG_VERSION}.tar.xz"
NEOTERM_PKG_SHA256=4334b8c7f3f2d5e65bb3b88e188324924102aff91ee7aa1066f9bc6f4bf66ca8
NEOTERM_PKG_DEPENDS="libc++, qt5-qtbase, liblxqt, libnotify"
NEOTERM_PKG_BUILD_DEPENDS="lxqt-build-tools, qt5-qtbase-cross-tools, qt5-qttools-cross-tools"
NEOTERM_PKG_AUTO_UPDATE=true

