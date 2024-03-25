NEOTERM_PKG_HOMEPAGE=https://github.com/badboy/mdbook-open-on-gh
NEOTERM_PKG_DESCRIPTION="A preprocessor for mdbook to add a open-on-github link on every page"
NEOTERM_PKG_LICENSE="MPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.4.2"
NEOTERM_PKG_SRCURL=git+https://github.com/badboy/mdbook-open-on-gh
NEOTERM_PKG_GIT_BRANCH=$NEOTERM_PKG_VERSION
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
	neoterm_setup_rust
	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/mdbook-open-on-gh
}
