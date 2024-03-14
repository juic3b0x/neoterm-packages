NEOTERM_PKG_HOMEPAGE=https://github.com/boozook/mdbook-svgbob
NEOTERM_PKG_DESCRIPTION="SvgBob mdbook preprocessor which swaps code-blocks with neat SVG"
NEOTERM_PKG_LICENSE="MPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.2.1
NEOTERM_PKG_SRCURL=https://github.com/boozook/mdbook-svgbob/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=cd5c6a58db33e87db04a1f9a5773de860b81cf75bafbe7a9fdb3f4b9f85cbbdc
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	neoterm_setup_rust
	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/mdbook-svgbob
}
