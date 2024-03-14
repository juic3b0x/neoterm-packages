NEOTERM_PKG_HOMEPAGE=https://rust-lang.github.io/mdBook/
NEOTERM_PKG_DESCRIPTION="Creates book from markdown files"
NEOTERM_PKG_LICENSE="MPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.4.37"
NEOTERM_PKG_SRCURL=https://github.com/rust-lang/mdBook/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=7a360cb8702d8a35d9db9d0639a6a4650d3a9492970cf772f49c5a99d981272c
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
	neoterm_setup_rust
	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

neoterm_step_make_install() {
	install -Dm755 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/mdbook
}
