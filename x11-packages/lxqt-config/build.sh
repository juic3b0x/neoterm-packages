NEOTERM_PKG_HOMEPAGE=https://lxqt.github.io
NEOTERM_PKG_DESCRIPTION="Tools to configure LXQt and the underlying operating system"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="Simeon Huang <symeon@librehat.com>"
NEOTERM_PKG_VERSION="1.4.0"
NEOTERM_PKG_SRCURL="https://github.com/lxqt/lxqt-config/releases/download/${NEOTERM_PKG_VERSION}/lxqt-config-${NEOTERM_PKG_VERSION}.tar.xz"
NEOTERM_PKG_SHA256=e60d5c3f00588fb373b48fa0c65f7a164500738467359472409a29b9db11c84b
NEOTERM_PKG_DEPENDS="libc++, liblxqt, libqtxdg, libxcb, libxcursor, libxfixes, lxqt-menu-data, qt5-qtbase, qt5-qtx11extras, shared-mime-info, zlib"
NEOTERM_PKG_BUILD_DEPENDS="lxqt-build-tools, qt5-qtbase-cross-tools, qt5-qttools-cross-tools"
# libinput is required to switch on input configuration
# libkscreen is required to switch on monitor configuration, which in turn requires wayland
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="-DWITH_INPUT=OFF -DWITH_MONITOR=OFF"
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_pre_configure() {
    # This is required because of the private lib used by lxqt-config-appearance
    LDFLAGS+=" -Wl,-rpath=${NEOTERM_PREFIX}/lib/lxqt-config"
    export LDFLAGS
}
