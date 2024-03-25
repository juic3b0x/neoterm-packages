NEOTERM_PKG_HOMEPAGE=https://lxqt.github.io
NEOTERM_PKG_DESCRIPTION="GUI to query passwords on behalf of SSH agents"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="Simeon Huang <symeon@librehat.com>"
NEOTERM_PKG_VERSION="1.4.0"
NEOTERM_PKG_SRCURL="https://github.com/lxqt/lxqt-openssh-askpass/releases/download/${NEOTERM_PKG_VERSION}/lxqt-openssh-askpass-${NEOTERM_PKG_VERSION}.tar.xz"
NEOTERM_PKG_SHA256=2ba6bcac5d90db846dce7895d03294126315ec20e59977f9f2faadf3e668c54a
NEOTERM_PKG_DEPENDS="libc++, qt5-qtbase, liblxqt"
NEOTERM_PKG_BUILD_DEPENDS="lxqt-build-tools, qt5-qtbase-cross-tools, qt5-qttools-cross-tools"
NEOTERM_PKG_AUTO_UPDATE=true

