NEOTERM_PKG_HOMEPAGE=https://github.com/dylanowen/mdbook-graphviz
NEOTERM_PKG_DESCRIPTION="mdbook preprocessor to add graphviz support"
NEOTERM_PKG_LICENSE="MPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.1.6"
NEOTERM_PKG_SRCURL=https://github.com/dylanowen/mdbook-graphviz/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=ca108e79797adb45a0ecbfffe744b310c11b2bdaceca327c8c6d0d01921dc8ce
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="graphviz"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	neoterm_setup_rust
	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/mdbook-graphviz
}
