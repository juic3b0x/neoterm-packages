NEOTERM_PKG_HOMEPAGE=https://github.com/mbrubeck/agate
NEOTERM_PKG_DESCRIPTION="Very simple server for the Gemini hypertext protocol"
NEOTERM_PKG_LICENSE="MIT, Apache-2.0"
NEOTERM_PKG_LICENSE_FILE="LICENSE-MIT, LICENSE-APACHE"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="3.3.4"
NEOTERM_PKG_SRCURL=https://github.com/mbrubeck/agate/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=1575e5166c6d4ec61e76406161e09c2332bc8037f65918216e2c0e11b3bac410
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	neoterm_setup_rust

	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

neoterm_step_make_install() {
	install -Dm755 -t $NEOTERM_PREFIX/bin $NEOTERM_PKG_SRCDIR/target/${CARGO_TARGET_NAME}/release/agate
}
