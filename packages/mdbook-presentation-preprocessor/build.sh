NEOTERM_PKG_HOMEPAGE=https://github.com/FreeMasen/mdbook-presentation-preprocessor
NEOTERM_PKG_DESCRIPTION="A preprocessor for utilizing an MDBook as slides for a presentation"
NEOTERM_PKG_LICENSE="MPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.3.1"
NEOTERM_PKG_SRCURL=https://github.com/FreeMasen/mdbook-presentation-preprocessor/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=477eb3104bfe216ebd2067bad97cc3e5a2116ae37bd3819cf523771d315733c6
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

# https://github.com/juic3b0x/neoterm-packages/issues/16755
NEOTERM_RUST_VERSION=1.68.2

neoterm_step_make() {
	neoterm_setup_rust
	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/mdbook-presentation-preprocessor
}
