NEOTERM_PKG_HOMEPAGE=https://github.com/pemistahl/grex
NEOTERM_PKG_DESCRIPTION="Simplifies the task of creating regular expressions"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.4.5"
NEOTERM_PKG_SRCURL=https://github.com/pemistahl/grex/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=4e849b29b387afc583856f24923b76052ad90e320c2caacfc6452e6d9deb6b14
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	neoterm_setup_rust
	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/grex
}
