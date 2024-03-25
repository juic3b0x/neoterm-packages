NEOTERM_PKG_HOMEPAGE=https://github.com/atanunq/viu
NEOTERM_PKG_DESCRIPTION="Terminal image viewer with native support for iTerm and Kitty"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_LICENSE_FILE="LICENSE-MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.5.0"
NEOTERM_PKG_SRCURL=https://github.com/atanunq/viu/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=9682be1561f7a128436bd2e45d1f8f7146ca1dd7f528a69bd3c171e4e855474b
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
	neoterm_setup_rust

	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/viu
}
