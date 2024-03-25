NEOTERM_PKG_HOMEPAGE=https://wkhtmltopdf.org/
NEOTERM_PKG_DESCRIPTION="wkhtmltopdf and wkhtmltoimage are command line tools to render HTML into PDF and various image formats using the QT Webkit rendering engine."
NEOTERM_PKG_LICENSE="LGPL-3.0"
NEOTERM_PKG_MAINTAINER="Yisus7u7 <dev.yisus@hotmail.com>"
NEOTERM_PKG_VERSION=0.12.6
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://github.com/wkhtmltopdf/wkhtmltopdf/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=adcced78492e7366d940c66a1327a85d3ae8c45190f486f545fdaa84cac662f0
NEOTERM_PKG_DEPENDS="libc++, qt5-qtbase, qt5-qtsvg, qt5-qtwebkit, qt5-qtxmlpatterns"
NEOTERM_PKG_BUILD_DEPENDS="qt5-qtbase-cross-tools"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_configure () {
	"${NEOTERM_PREFIX}/opt/qt/cross/bin/qmake" \
		-spec "${NEOTERM_PREFIX}/lib/qt/mkspecs/neoterm-cross"
}

neoterm_step_make_install () {
	cd ${NEOTERM_PKG_SRCDIR}/bin
	install -Dm700 -t ${NEOTERM_PREFIX}/lib ./*.so*
	install -Dm700 -t ${NEOTERM_PREFIX}/bin ./wkhtmltoimage ./wkhtmltopdf
}

