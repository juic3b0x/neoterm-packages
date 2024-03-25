NEOTERM_PKG_HOMEPAGE=https://github.com/KDE/trojita
NEOTERM_PKG_DESCRIPTION="Fast, lightweight and standard-compliant IMAP e-mail client"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="Yisus7u7 <dev.yisus@hotmail.com>"
NEOTERM_PKG_VERSION=0.7
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://github.com/KDE/trojita/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=7cf5e2202343508904e553db239b02754a98aebf6d2a2d90aa2a089724029a20
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_DEPENDS="libc++, qt5-qtbase, qt5-qtsvg, qt5-qtwebkit, zlib"
NEOTERM_PKG_BUILD_DEPENDS="qt5-qtbase-cross-tools, qt5-qttools-cross-tools"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DWITH_TESTS=OFF
"
