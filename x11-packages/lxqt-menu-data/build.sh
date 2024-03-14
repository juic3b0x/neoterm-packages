NEOTERM_PKG_HOMEPAGE=https://github.com/lxqt/lxqt-menu-data
NEOTERM_PKG_DESCRIPTION="Menu files for LXQt Panel, Configuration Center and PCManFM-Qt/libfm-qt"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.4.1"
NEOTERM_PKG_SRCURL="https://github.com/lxqt/lxqt-menu-data/releases/download/$NEOTERM_PKG_VERSION/lxqt-menu-data-$NEOTERM_PKG_VERSION.tar.xz"
NEOTERM_PKG_SHA256=87b4d372afcf61ec2272ceb5eedba873d8a8a73e5b239a55446b52950b72d596
NEOTERM_PKG_BUILD_DEPENDS="lxqt-build-tools, qt5-qtbase-cross-tools, qt5-qttools-cross-tools"
NEOTERM_PKG_BREAKS="lxqt-panel (<= 1.3.0)"
NEOTERM_PKG_CONFLICTS="lxqt-panel (<= 1.3.0)"
NEOTERM_PKG_AUTO_UPDATE=true
