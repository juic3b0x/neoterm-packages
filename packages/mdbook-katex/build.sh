NEOTERM_PKG_HOMEPAGE=https://github.com/lzanini/mdbook-katex
NEOTERM_PKG_DESCRIPTION="A preprocessor for mdBook, pre-rendering LaTex equations to HTML at build time"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.6.0"
NEOTERM_PKG_SRCURL=https://github.com/lzanini/mdbook-katex/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=9d3a21c010ce61617555834e60c1270d50717c04c228753059abd91523c78baa
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="openssl"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	export OPENSSL_INCLUDE_DIR=$NEOTERM_PREFIX/include/openssl
	export OPENSSL_LIB_DIR=$NEOTERM_PREFIX/lib
}

neoterm_step_make() {
	neoterm_setup_rust
	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/mdbook-katex
}
