NEOTERM_PKG_HOMEPAGE=https://github.com/kaegi/alass
NEOTERM_PKG_DESCRIPTION="Automatic Language-Agnostic Subtitle Synchronization"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.0.0
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL="https://github.com/kaegi/alass/archive/v$NEOTERM_PKG_VERSION.tar.gz"
NEOTERM_PKG_SHA256=ce88f92c7a427b623edcabb1b64e80be70cca2777f3da4b96702820a6cdf1e26
NEOTERM_PKG_DEPENDS="ffmpeg"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	rm -f Makefile
}

neoterm_step_make_install() {
	neoterm_setup_rust
	cargo install \
		--jobs $NEOTERM_MAKE_PROCESSES \
		--path alass-cli \
		--force \
		--locked \
		--target $CARGO_TARGET_NAME \
		--root $NEOTERM_PREFIX \
		$NEOTERM_PKG_EXTRA_CONFIGURE_ARGS
	# https://github.com/rust-lang/cargo/issues/3316:
	rm -f $NEOTERM_PREFIX/.crates.toml
	rm -f $NEOTERM_PREFIX/.crates2.json
}

neoterm_step_post_make_install() {
	install -Dm644 LICENSE "$NEOTERM_PREFIX/share/licenses/alass/LICENSE"
}
