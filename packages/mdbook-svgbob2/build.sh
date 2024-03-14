NEOTERM_PKG_HOMEPAGE=https://github.com/matthiasbeyer/mdbook-svgbob2
NEOTERM_PKG_DESCRIPTION="Alternative mdbook preprocessor for svgbob"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.3.0
NEOTERM_PKG_SRCURL=https://github.com/matthiasbeyer/mdbook-svgbob2/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=9e36746b4975dfa3db996a3e890fea57810493c48aa18f7bd09dc4b5a76f5a96
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	neoterm_setup_rust
	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/mdbook-svgbob2
}
