NEOTERM_PKG_HOMEPAGE="https://github.com/jridgewell/rw"
NEOTERM_PKG_DESCRIPTION="A Rust implementation of sponge(1) that never write to TMPDIR"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.0.1
NEOTERM_PKG_SRCURL=("https://github.com/jridgewell/rw/archive/c13c24e011ef5a79ea60bc51bb0d3fa930326146.tar.gz")
NEOTERM_PKG_SHA256=(699c32045c713bcfc8e7b89d5bd24d89d1cbb887ba8570b857391f98b64e6a9a)
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	neoterm_setup_rust
	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/rw
}
