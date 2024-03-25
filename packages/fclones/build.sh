NEOTERM_PKG_HOMEPAGE="https://github.com/pkolaczk/fclones"
NEOTERM_PKG_DESCRIPTION="Efficient Duplicate File Finder"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.34.0"
NEOTERM_PKG_SRCURL="https://github.com/pkolaczk/fclones/archive/refs/tags/v$NEOTERM_PKG_VERSION.tar.gz"
NEOTERM_PKG_SHA256=5e8c94bb5fb313a5c228bdc870cf6605487338f31c5a14305e54e7e3ac15d0ad
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make_install() {
	neoterm_setup_rust
	cargo install \
		--jobs $NEOTERM_MAKE_PROCESSES \
		--path $NEOTERM_PKG_SRCDIR/fclones \
		--force \
		--locked \
		--no-track \
		--target $CARGO_TARGET_NAME \
		--root $NEOTERM_PREFIX
}
