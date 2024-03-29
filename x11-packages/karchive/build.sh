NEOTERM_PKG_HOMEPAGE=https://www.kde.org/
NEOTERM_PKG_DESCRIPTION="Qt 5 addon providing access to numerous types of archives (KDE)"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="Simeon Huang <symeon@librehat.com>"
NEOTERM_PKG_VERSION="5.112.0"
NEOTERM_PKG_SRCURL="https://download.kde.org/stable/frameworks/${NEOTERM_PKG_VERSION%.*}/karchive-${NEOTERM_PKG_VERSION}.tar.xz"
NEOTERM_PKG_SHA256=27d697a52a5016c16081c6a414b390d96350450d6eeb889d1f463358eeebfd67
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libbz2, libc++, liblzma, qt5-qtbase, zlib, zstd"
NEOTERM_PKG_BUILD_DEPENDS="extra-cmake-modules, qt5-qtbase-cross-tools, qt5-qttools-cross-tools"
