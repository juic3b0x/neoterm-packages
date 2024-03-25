NEOTERM_PKG_HOMEPAGE=https://github.com/rust-lang/rust-bindgen
NEOTERM_PKG_DESCRIPTION="Automatically generates Rust FFI bindings to C (and some C++) libraries"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.69.4"
NEOTERM_PKG_SRCURL=https://github.com/rust-lang/rust-bindgen/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=c02ce18b95c4e5021b95b8b461e5dbe6178edffc52a5f555cbca35b910559b5e
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"

neoterm_step_pre_configure() {
	neoterm_setup_rust
}

neoterm_step_make() {
	local BUILD_TYPE=
	if [ $NEOTERM_DEBUG_BUILD = false ]; then
		BUILD_TYPE=--release
	fi

	cargo build --jobs $NEOTERM_MAKE_PROCESSES \
		--target $CARGO_TARGET_NAME ${BUILD_TYPE}
}

neoterm_step_make_install() {
	local BUILD_TYPE=release
	if [ $NEOTERM_DEBUG_BUILD = true ]; then
		BUILD_TYPE=debug
	fi

	install -Dm755 -t $NEOTERM_PREFIX/bin \
		target/${CARGO_TARGET_NAME}/${BUILD_TYPE}/bindgen
}
