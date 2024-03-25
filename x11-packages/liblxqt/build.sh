NEOTERM_PKG_HOMEPAGE=https://lxqt.github.io
NEOTERM_PKG_DESCRIPTION="The core library of LXQt"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="Simeon Huang <symeon@librehat.com>"
NEOTERM_PKG_VERSION="1.4.0"
NEOTERM_PKG_SRCURL="https://github.com/lxqt/liblxqt/releases/download/${NEOTERM_PKG_VERSION}/liblxqt-${NEOTERM_PKG_VERSION}.tar.xz"
NEOTERM_PKG_SHA256=b55073e7673e19d30339cabf5692a86b3aee244f3009f67e424b7c919f4d96f0
NEOTERM_PKG_DEPENDS="libc++, qt5-qtbase, qt5-qtx11extras, kwindowsystem, libqtxdg, libxss"
NEOTERM_PKG_BUILD_DEPENDS="lxqt-build-tools, qt5-qtbase-cross-tools"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="-DBUILD_BACKLIGHT_LINUX_BACKEND=OFF"
NEOTERM_PKG_AUTO_UPDATE=true
