NEOTERM_PKG_HOMEPAGE="https://github.com/wfxr/csview"
NEOTERM_PKG_DESCRIPTION="Pretty-printing CSV/TSV/xSV on terminal"
NEOTERM_PKG_LICENSE="MIT, Apache-2.0"
NEOTERM_PKG_LICENSE_FILE="LICENSE-MIT"
NEOTERM_PKG_MAINTAINER="@flosnvjx"
NEOTERM_PKG_VERSION="1.2.4"
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_SRCURL="$NEOTERM_PKG_HOMEPAGE/archive/v$NEOTERM_PKG_VERSION.tar.gz"
NEOTERM_PKG_SHA256=ff796fec2757186133c8b61caec8f774c44cb8e1400d014a29930601760e6a36

NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	neoterm_setup_rust
	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release --locked
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/csview
	install -Dm600 -t $NEOTERM_PREFIX/share/doc/$NEOTERM_PKG_NAME README.*
	install -Dm600 "completions/fish/csview.fish" "$NEOTERM_PREFIX/share/fish/vendor_completions.d/csview.fish"
	install -Dm600 "completions/zsh/_csview" "$NEOTERM_PREFIX/share/zsh/site-functions/_csview"
	install -Dm600 "completions/bash/csview.bash" "$NEOTERM_PREFIX/share/bash-completion/completions/csview"

	# https://github.com/elves/elvish/issues/1564#issuecomment-1166333636
	install -Dm600 "completions/elvish/csview.elv" -t $NEOTERM_PREFIX/share/elvish/lib
}
