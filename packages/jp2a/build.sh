NEOTERM_PKG_HOMEPAGE=https://csl.name/jp2a/
NEOTERM_PKG_DESCRIPTION="A simple JPEG to ASCII converter"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.2.0"
NEOTERM_PKG_SRCURL=https://github.com/Talinx/jp2a/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=a19088bb4ba27e8a5524f26f0f1622529ca087e36f5a060c6535c11b266106d1
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libcurl, libjpeg-turbo, libpng, ncurses"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	autoreconf -vi
}
