NEOTERM_PKG_HOMEPAGE=https://www.freedesktop.org/wiki/Software/fontconfig/
NEOTERM_PKG_DESCRIPTION="Library for configuring and customizing font access"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.15.0"
NEOTERM_PKG_SRCURL=https://www.freedesktop.org/software/fontconfig/release/fontconfig-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=63a0658d0e06e0fa886106452b58ef04f21f58202ea02a94c39de0d3335d7c0e
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="freetype, libexpat, ttf-dejavu"
NEOTERM_PKG_BREAKS="fontconfig-dev"
NEOTERM_PKG_REPLACES="fontconfig-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--enable-libxml2=no
--enable-iconv=no
--disable-docs
--with-default-fonts=/system/fonts
--with-add-fonts=$NEOTERM_PREFIX/share/fonts
"
