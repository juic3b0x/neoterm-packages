NEOTERM_PKG_HOMEPAGE=https://github.com/avitex/mdbook-tera
NEOTERM_PKG_DESCRIPTION="Tera preprocessor for mdBook"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.5.1
NEOTERM_PKG_SRCURL=https://github.com/avitex/mdbook-tera/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=676477d95fa0b8f23962ccf52aa4b394d0ebac0044d33f9f11d995d8d3b98d3d
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	neoterm_setup_rust

	: "${CARGO_HOME:=$HOME/.cargo}"
	export CARGO_HOME

	cargo fetch --target "${CARGO_TARGET_NAME}"

	local _patch=$NEOTERM_PKG_BUILDER_DIR/mdbook-src-renderer-html_handlebars-helpers-navigation.rs.diff
	local d
	for d in $CARGO_HOME/registry/src/*/mdbook-*; do
		patch --silent -p1 -d ${d} < ${_patch} || :
	done
}

neoterm_step_make() {
	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/mdbook-tera
}
