NEOTERM_PKG_HOMEPAGE=https://github.com/tsujan/Kvantum
NEOTERM_PKG_DESCRIPTION="SVG-based theme engine for Qt5"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="Simeon Huang <symeon@librehat.com>"
NEOTERM_PKG_VERSION="1.0.10"
NEOTERM_PKG_SRCURL="https://github.com/tsujan/Kvantum/releases/download/V${NEOTERM_PKG_VERSION}/Kvantum-${NEOTERM_PKG_VERSION}.tar.xz"
NEOTERM_PKG_SHA256=4a070a1a6fac3d1861010aa44d34e665e4697bc64c4c5015a6448203c31f1f1f
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
NEOTERM_PKG_DEPENDS="kwindowsystem, libc++, libx11, qt5-qtbase, qt5-qtsvg, qt5-qtx11extras"
NEOTERM_PKG_BUILD_DEPENDS="qt5-qtbase-cross-tools, qt5-qttools-cross-tools"

neoterm_step_post_get_source() {
	NEOTERM_PKG_SRCDIR+="/Kvantum"
}
