NEOTERM_PKG_HOMEPAGE=https://pngquant.org/lib/
NEOTERM_PKG_DESCRIPTION="Small, portable C library for high-quality conversion of RGBA images to 8-bit indexed-color (palette) images"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_LICENSE_FILE="COPYRIGHT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="4.3.0"
NEOTERM_PKG_SRCURL=https://github.com/ImageOptim/libimagequant/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=7f590ed400def273381ac066f46b9f9e8b3e0b1985a5b7e82ca7a65541a6681b
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	NEOTERM_PKG_SRCDIR+="/imagequant-sys"
	NEOTERM_PKG_BUILDDIR="$NEOTERM_PKG_SRCDIR"
}

neoterm_step_make() {
	:
}

neoterm_step_make_install() {
	neoterm_setup_rust
	neoterm_setup_cargo_c
	cargo cinstall \
		--target $CARGO_TARGET_NAME \
		--prefix $NEOTERM_PREFIX \
		--jobs $NEOTERM_MAKE_PROCESSES
}
