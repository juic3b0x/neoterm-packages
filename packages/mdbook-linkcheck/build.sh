NEOTERM_PKG_HOMEPAGE=https://michael-f-bryan.github.io/mdbook-linkcheck/
NEOTERM_PKG_DESCRIPTION="A backend for mdbook which will check your links for you"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.7.7
NEOTERM_PKG_SRCURL=https://github.com/Michael-F-Bryan/mdbook-linkcheck/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=3194243acf12383bd328a9440ab1ae304e9ba244d3bd7f85f1c23b0745c4847a
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	neoterm_setup_rust
	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/mdbook-linkcheck
}
