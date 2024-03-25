NEOTERM_PKG_HOMEPAGE=https://github.com/ThiBsc/debpac
NEOTERM_PKG_DESCRIPTION="A Debian package creator assistant"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="Yisus7u7 <yisus7u7v@gmail.com>"
NEOTERM_PKG_VERSION=1.7
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL="https://github.com/ThiBsc/debpac/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz"
NEOTERM_PKG_SHA256=402f9dfcc739fb64666832f1a0d5b47295c900a22232150af4cc069b420515c9
NEOTERM_PKG_DEPENDS="libc++, qt5-qtbase, qt5-qtsvg"
NEOTERM_PKG_BUILD_DEPENDS="qt5-qtbase-cross-tools, qt5-qttools-cross-tools"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_configure () {
    "${NEOTERM_PREFIX}/opt/qt/cross/bin/qmake" \
        -spec "${NEOTERM_PREFIX}/lib/qt/mkspecs/neoterm-cross" \
        PREFIX="${NEOTERM_PREFIX}"
}

neoterm_step_make_install () {
	cd ${NEOTERM_PKG_SRCDIR}
	install -Dm700 -t ${NEOTERM_PREFIX}/bin ./debpac
}
