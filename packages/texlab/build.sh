NEOTERM_PKG_HOMEPAGE=https://texlab.netlify.app/
NEOTERM_PKG_DESCRIPTION="A cross-platform implementation of the Language Server Protocol providing rich cross-editing support for the LaTeX typesetting system"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="5.13.0"
NEOTERM_PKG_SRCURL=git+https://github.com/latex-lsp/texlab
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
	neoterm_setup_rust
	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/texlab
}
