NEOTERM_PKG_HOMEPAGE=https://github.com/gjk-cat/cat-prep
NEOTERM_PKG_DESCRIPTION="A preprocessor for mdbook which provides teacher, subject, material and tag functionality"
NEOTERM_PKG_LICENSE="Fair"
NEOTERM_PKG_LICENSE_FILE="LICENSE"
NEOTERM_PKG_MAINTAINER="@neoterm"
_COMMIT=fbf5ca360337452ca5ef7437d64c2efd7d891aec
NEOTERM_PKG_VERSION=1.0.9
NEOTERM_PKG_SRCURL=git+https://github.com/gjk-cat/cat-prep
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_GIT_BRANCH=master
NEOTERM_PKG_BUILD_IN_SRC=true

# https://github.com/juic3b0x/neoterm-packages/issues/16756
NEOTERM_RUST_VERSION=1.68.2

neoterm_step_post_get_source() {
	git fetch --unshallow
	git checkout $_COMMIT

	local ver=$(sed -En 's/^version = "([^"]+)".*/\1/p' Cargo.toml)
	if [ "${ver}" != "${NEOTERM_PKG_VERSION#*:}" ]; then
		neoterm_error_exit "Version string '$NEOTERM_PKG_VERSION' does not seem to be correct."
	fi
}

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
	install -Dm700 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/mdbook-cat-prep
}
