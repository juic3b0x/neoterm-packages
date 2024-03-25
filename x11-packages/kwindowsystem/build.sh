NEOTERM_PKG_HOMEPAGE=https://www.kde.org/
NEOTERM_PKG_DESCRIPTION="KDE Access to window manager"
NEOTERM_PKG_LICENSE="LGPL-2.1, LGPL-3.0, MIT"
NEOTERM_PKG_LICENSE_FILE="\
LICENSES/CC0-1.0.txt
LICENSES/LGPL-2.1-only.txt
LICENSES/LGPL-2.1-or-later.txt
LICENSES/LGPL-3.0-only.txt
LICENSES/LicenseRef-KDE-Accepted-LGPL.txt
LICENSES/MIT.txt"
NEOTERM_PKG_MAINTAINER="Simeon Huang <symeon@librehat.com>"
NEOTERM_PKG_VERSION="5.112.0"
NEOTERM_PKG_SRCURL="https://download.kde.org/stable/frameworks/${NEOTERM_PKG_VERSION%.*}/kwindowsystem-${NEOTERM_PKG_VERSION}.tar.xz"
NEOTERM_PKG_SHA256=418e13e52f66a4030757d8479c787adab1112f40f694c0cc26309d84bf793022
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libc++, libx11, libxcb, libxfixes, qt5-qtbase, qt5-qtx11extras, xcb-util-keysyms"
NEOTERM_PKG_BUILD_DEPENDS="extra-cmake-modules, qt5-qttools-cross-tools"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="-DCMAKE_INSTALL_PREFIX=${NEOTERM_PREFIX}"
