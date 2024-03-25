NEOTERM_PKG_HOMEPAGE=https://github.com/sharkdp/pastel
NEOTERM_PKG_DESCRIPTION="A command-line tool to generate, analyze, convert and manipulate colors"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_LICENSE_FILE="LICENSE-MIT, LICENSE-APACHE"
NEOTERM_PKG_MAINTAINER="Yaksh Bariya <thunder-coding@neoterm.dev>"
NEOTERM_PKG_VERSION="0.9.0"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/sharkdp/pastel/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=473c805de42f6849a4bb14ec103ca007441f355552bdb6ebc80b60dac1f3a95d
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	neoterm_setup_rust
}

neoterm_step_make() {
	SHELL_COMPLETIONS_DIR=$NEOTERM_PKG_BUILDDIR/completions cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

neoterm_step_make_install() {
	install -Dm755 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/pastel

	# Install completions
	install -Dm600 $NEOTERM_PKG_BUILDDIR/completions/_pastel \
		$NEOTERM_PREFIX/share/zsh/site-functions/_pastel
	install -Dm600 $NEOTERM_PKG_BUILDDIR/completions/pastel.bash \
		$NEOTERM_PREFIX/share/bash-completion/completions/pastel.bash
	install -Dm600 $NEOTERM_PKG_BUILDDIR/completions/pastel.fish \
		$NEOTERM_PREFIX/share/fish/vendor_completions.d/pastel.fish
}
