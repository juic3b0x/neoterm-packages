NEOTERM_PKG_HOMEPAGE=https://github.com/spacejam/sled
NEOTERM_PKG_DESCRIPTION="A lightweight pure-rust high-performance transactional embedded database"
NEOTERM_PKG_LICENSE="Apache-2.0, MIT"
NEOTERM_PKG_LICENSE_FILE="LICENSE-APACHE, LICENSE-MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.34.7
NEOTERM_PKG_SRCURL=https://github.com/spacejam/sled/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=dd1c757464b970a4eb73c954b345be63655c84bb1de249af3c3a609c57763046

neoterm_step_post_get_source() {
	sed -e "s%\@NEOTERM_PKG_VERSION\@%${NEOTERM_PKG_VERSION}%g" \
		$NEOTERM_PKG_BUILDER_DIR/bindings-sled-native-Cargo.toml.diff | \
		patch --silent -p1
}

neoterm_step_pre_configure() {
	NEOTERM_PKG_BUILDDIR="$NEOTERM_PKG_SRCDIR/bindings/sled-native"
}

neoterm_step_make() {
	neoterm_setup_rust
	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

neoterm_step_make_install() {
	install -Dm600 -t $NEOTERM_PREFIX/lib target/${CARGO_TARGET_NAME}/release/libsled.so
}
