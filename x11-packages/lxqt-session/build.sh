NEOTERM_PKG_HOMEPAGE=https://lxqt.github.io
NEOTERM_PKG_DESCRIPTION="The LXQt session manager"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="Simeon Huang <symeon@librehat.com>"
NEOTERM_PKG_VERSION="1.4.0"
NEOTERM_PKG_SRCURL="https://github.com/lxqt/lxqt-session/releases/download/${NEOTERM_PKG_VERSION}/lxqt-session-${NEOTERM_PKG_VERSION}.tar.xz"
NEOTERM_PKG_SHA256=9dcdc846601f1972d01429f2203d36976088edcca5c166eef2b21ad73fcef656
NEOTERM_PKG_DEPENDS="libc++, qt5-qtbase, qt5-qtx11extras, qtxdg-tools, kwindowsystem, liblxqt, procps, libandroid-wordexp"
NEOTERM_PKG_BUILD_DEPENDS="lxqt-build-tools, qt5-qtbase-cross-tools, qt5-qttools-cross-tools"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="-DWITH_LIBUDEV=OFF"
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_pre_configure(){
	LDFLAGS+=" -landroid-wordexp"
}
