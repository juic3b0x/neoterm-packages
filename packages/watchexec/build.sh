NEOTERM_PKG_HOMEPAGE=https://github.com/watchexec/watchexec
NEOTERM_PKG_DESCRIPTION="Executes commands in response to file modifications"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.22.3
NEOTERM_PKG_SRCURL=https://github.com/watchexec/watchexec/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=698ed1dc178279594542f325b23f321c888c9c12c1960fe11c0ca48ba6edad76
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make_install() {
	neoterm_setup_rust
	cargo install \
		--jobs $NEOTERM_MAKE_PROCESSES \
		--path crates/cli \
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
	local f
	for f in doc/watchexec.1.{md,pdf}; do
		install -Dm600 -t "$NEOTERM_PREFIX/share/doc/$NEOTERM_PKG_NAME" \
			"$NEOTERM_PKG_SRCDIR/${f}"
	done
	install -Dm600 -t "$NEOTERM_PREFIX/share/man/man1" \
		"$NEOTERM_PKG_SRCDIR"/doc/watchexec.1
	install -Dm600 -T "completions/bash" \
		"$NEOTERM_PREFIX/share/bash-completion/completions/watchexec"
	install -Dm600 -T "completions/zsh" \
		"$NEOTERM_PREFIX/share/zsh/site-functions/_watchexec"
	install -Dm600 -T "completions/fish" \
		"$NEOTERM_PREFIX/share/fish/vendor_completions.d/watchexec.fish"
}
