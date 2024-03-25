NEOTERM_PKG_HOMEPAGE=http://www.pixman.org/
NEOTERM_PKG_DESCRIPTION="Low-level library for pixel manipulation"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.42.2
NEOTERM_PKG_SRCURL=https://cairographics.org/releases/pixman-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=ea1480efada2fd948bc75366f7c349e1c96d3297d09a3fe62626e38e234a625e
NEOTERM_PKG_BUILD_DEPENDS="binutils-cross"
NEOTERM_PKG_BREAKS="libpixman-dev"
NEOTERM_PKG_REPLACES="libpixman-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--disable-libpng"

neoterm_step_pre_configure() {
	if [ "$NEOTERM_ARCH" = arm ] || [ "$NEOTERM_ARCH" = aarch64 ]; then
		neoterm_setup_no_integrated_as
	fi
}
