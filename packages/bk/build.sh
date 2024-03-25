NEOTERM_PKG_HOMEPAGE=https://github.com/aeosynth/bk
NEOTERM_PKG_DESCRIPTION="A terminal EPUB reader"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.6.0"
NEOTERM_PKG_SRCURL=https://github.com/aeosynth/bk/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=c720c8e81e86709f8543ca1a97a3c30b3bb33d55692a536cefed0ad2e3dfabcd
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	neoterm_setup_rust
}

neoterm_step_make() {
	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/bk
}
