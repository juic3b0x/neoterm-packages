NEOTERM_PKG_HOMEPAGE="https://github.com/ismaelgv/rnr"
NEOTERM_PKG_DESCRIPTION="Batch rename files and directories using regular expression (rust)"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@flosnvjx"
NEOTERM_PKG_VERSION="0.4.2"
NEOTERM_PKG_SRCURL="https://github.com/ismaelgv/rnr/archive/refs/tags/v$NEOTERM_PKG_VERSION.tar.gz"
NEOTERM_PKG_SHA256=cde8e5366552263300e60133b82f6a3868aeced2fe83abc91c2168085dff0998
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
	neoterm_setup_rust
	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release --locked
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/rnr
	install -Dm600 -t $NEOTERM_PREFIX/share/doc/$NEOTERM_PKG_NAME README.* CHANGELOG*
}
