NEOTERM_PKG_HOMEPAGE=https://github.com/podsvirov/mdbook-pikchr
NEOTERM_PKG_DESCRIPTION="A mdbook preprocessor to render pikchr code blocks as images in your book"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.1.7"
NEOTERM_PKG_SRCURL=git+https://github.com/podsvirov/mdbook-pikchr
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
	neoterm_setup_rust
	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/mdbook-pikchr
}
