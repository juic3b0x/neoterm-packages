NEOTERM_PKG_HOMEPAGE=https://github.com/Yisus7u7/lxqt-composer-settings
NEOTERM_PKG_DESCRIPTION="lxqt-composer-settings is an unofficial application to configure composition effects in LXQt."
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@Yisus7u7 <dev.yisus@hotmail.com>"
NEOTERM_PKG_VERSION=1.0.1
NEOTERM_PKG_SRCURL=https://github.com/Yisus7u7/lxqt-composer-settings/releases/download/${NEOTERM_PKG_VERSION}/lxqt-composer-settings-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=d538a73302dd81c85fa3e9d3b2be7937435a73321b6dc11099db75d033181d50
NEOTERM_PKG_DEPENDS="libc++, qt5-qtbase, qt5-qtsvg, xcompmgr, picom"
NEOTERM_PKG_RECOMMENDS="featherpad"
NEOTERM_PKG_BUILD_DEPENDS="qt5-qtbase-cross-tools, qt5-qttools-cross-tools"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_configure(){
    "${NEOTERM_PREFIX}/opt/qt/cross/bin/qmake" \
        -spec "${NEOTERM_PREFIX}/lib/qt/mkspecs/neoterm-cross" PREFIX=${NEOTERM_PREFIX}
}
