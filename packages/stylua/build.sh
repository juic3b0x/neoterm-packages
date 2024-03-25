NEOTERM_PKG_HOMEPAGE=https://github.com/JohnnyMorganz/StyLua
NEOTERM_PKG_DESCRIPTION="An opinionated Lua code formatter"
NEOTERM_PKG_LICENSE="MPL-2.0"
NEOTERM_PKG_MAINTAINER="@shadmansaleh"
NEOTERM_PKG_VERSION="0.20.0"
NEOTERM_PKG_SRCURL=https://github.com/JohnnyMorganz/StyLua/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=f4a27b12669953d2edf55b89cc80381f97a2dfa735f53f95c6ae6015c8c35ffb
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	neoterm_setup_rust
	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release --all-features

}

neoterm_step_make_install() {
	install -Dm755 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/stylua
}
