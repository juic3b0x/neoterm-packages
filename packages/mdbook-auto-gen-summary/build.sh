NEOTERM_PKG_HOMEPAGE=https://github.com/cococolanosugar/mdbook-auto-gen-summary
NEOTERM_PKG_DESCRIPTION="A preprocessor and cli tool for mdbook to auto generate summary"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
_COMMIT=a8e1d8edba05c52d927880a5fe2b97180441c955
NEOTERM_PKG_VERSION=0.1.10
NEOTERM_PKG_SRCURL=git+https://github.com/cococolanosugar/mdbook-auto-gen-summary
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_GIT_BRANCH=master
NEOTERM_PKG_BUILD_IN_SRC=true

# https://github.com/juic3b0x/neoterm-packages/issues/12824
NEOTERM_RUST_VERSION=1.63.0

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

	local _patch=$NEOTERM_PKG_BUILDER_DIR/filetime-src-unix-utimes.rs.diff
	local d
	for d in $CARGO_HOME/registry/src/*/filetime-*; do
		patch --silent -p1 -d ${d} < ${_patch} || :
	done
}

neoterm_step_make() {
	neoterm_setup_rust
	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/mdbook-auto-gen-summary
}
