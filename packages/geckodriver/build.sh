NEOTERM_PKG_HOMEPAGE=https://github.com/mozilla/geckodriver
NEOTERM_PKG_DESCRIPTION="Proxy for using W3C WebDriver-compatible clients to interact with Gecko-based browsers"
NEOTERM_PKG_LICENSE="MPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.33.0
NEOTERM_PKG_SRCURL=https://github.com/mozilla/geckodriver/archive/refs/tags/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=f796679ae35a4c32b9248da9401f058578e06eec1808f4ce0abb76e2ee64b653
NEOTERM_PKG_RECOMMENDS="firefox"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	neoterm_setup_rust
	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --bin geckodriver --release
}

neoterm_step_make_install() {
	install -Dm755 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/geckodriver
	ln -sf $NEOTERM_PREFIX/bin/geckodriver $NEOTERM_PREFIX/bin/wires
}
