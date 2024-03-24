TERMUX_PKG_HOMEPAGE=https://github.com/mozilla/geckodriver
TERMUX_PKG_DESCRIPTION="Proxy for using W3C WebDriver-compatible clients to interact with Gecko-based browsers"
TERMUX_PKG_LICENSE="MPL-2.0"
TERMUX_PKG_MAINTAINER="@neoterm"
TERMUX_PKG_VERSION=0.33.0
TERMUX_PKG_SRCURL=https://github.com/mozilla/geckodriver/archive/refs/tags/v$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=f796679ae35a4c32b9248da9401f058578e06eec1808f4ce0abb76e2ee64b653
TERMUX_PKG_RECOMMENDS="firefox"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_make() {
	termux_setup_rust
	cargo build --jobs $TERMUX_MAKE_PROCESSES --target $CARGO_TARGET_NAME --bin geckodriver --release
}

termux_step_make_install() {
	install -Dm755 -t $TERMUX_PREFIX/bin target/${CARGO_TARGET_NAME}/release/geckodriver
	ln -sf $TERMUX_PREFIX/bin/geckodriver $TERMUX_PREFIX/bin/wires
}
