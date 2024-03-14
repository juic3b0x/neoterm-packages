NEOTERM_PKG_HOMEPAGE=https://typst.app/
NEOTERM_PKG_DESCRIPTION="A new markup-based typesetting system that is powerful and easy to learn"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.10.0"
NEOTERM_PKG_SRCURL=git+https://github.com/typst/typst
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
	neoterm_setup_rust
	cargo build --jobs $NEOTERM_MAKE_PROCESSES -p typst-cli --target $CARGO_TARGET_NAME --release
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/typst
}
