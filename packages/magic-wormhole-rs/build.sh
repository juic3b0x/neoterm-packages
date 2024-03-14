NEOTERM_PKG_HOMEPAGE="https://github.com/magic-wormhole/magic-wormhole.rs"
NEOTERM_PKG_DESCRIPTION=" Rust implementation of Magic Wormhole, with new features and enhancements"
NEOTERM_PKG_LICENSE="EUPL-1.2"
NEOTERM_PKG_LICENSE_FILE="LICENSE"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.6.0
NEOTERM_PKG_SRCURL="https://github.com/magic-wormhole/magic-wormhole.rs/archive/refs/tags/$NEOTERM_PKG_VERSION.tar.gz"
NEOTERM_PKG_SHA256=cfa72215b1b0f519b9986523d0c41d6b3e562c41668f28ee80c23ce0aa3fe685
NEOTERM_PKG_BUILD_IN_SRC=true
# disable auto-update since 'remove-clipboard' patch was maually crafted for v0.6.0
NEOTERM_PKG_AUTO_UPDATE=false

neoterm_step_make() {
	neoterm_setup_rust
	cargo build --jobs "$NEOTERM_MAKE_PROCESSES" --target "$CARGO_TARGET_NAME" --release
}

neoterm_step_make_install() {
	install -Dm700 -t "$NEOTERM_PREFIX/bin" "target/${CARGO_TARGET_NAME}/release/wormhole-rs"
}
