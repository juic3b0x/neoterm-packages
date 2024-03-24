TERMUX_PKG_HOMEPAGE=https://github.com/Matroska-Org/libebml
TERMUX_PKG_DESCRIPTION="Extensible Binary Meta Language library"
TERMUX_PKG_LICENSE="LGPL-2.1"
TERMUX_PKG_MAINTAINER="@neoterm"
TERMUX_PKG_VERSION="1.4.5"
TERMUX_PKG_SRCURL=https://github.com/Matroska-Org/libebml/archive/release-$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=86c99573cd0957884f26547d1a8fa0c979e4d6d57484dfd387345846e6720f49
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_UPDATE_METHOD=repology
TERMUX_PKG_DEPENDS="libc++"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_SHARED_LIBS=ON
"
