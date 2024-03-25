NEOTERM_PKG_HOMEPAGE=https://lxqt.github.io
NEOTERM_PKG_DESCRIPTION="LXQt application launcher"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="Simeon Huang <symeon@librehat.com>"
NEOTERM_PKG_VERSION="1.4.0"
NEOTERM_PKG_SRCURL="https://github.com/lxqt/lxqt-runner/releases/download/${NEOTERM_PKG_VERSION}/lxqt-runner-${NEOTERM_PKG_VERSION}.tar.xz"
NEOTERM_PKG_SHA256=d59fc6da61b6fde1f4c36216f7e18e157f6b8a2a48cdf6bb26380443494152d2
NEOTERM_PKG_DEPENDS="libc++, qt5-qtbase, libqtxdg, kwindowsystem, liblxqt, lxqt-globalkeys"
NEOTERM_PKG_BUILD_DEPENDS="lxqt-build-tools, qt5-qtbase-cross-tools, qt5-qttools-cross-tools"
NEOTERM_PKG_AUTO_UPDATE=true

# TODO runner math depends on muparser
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="-DRUNNER_MATH=OFF"
