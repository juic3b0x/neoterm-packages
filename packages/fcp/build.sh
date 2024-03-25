NEOTERM_PKG_HOMEPAGE=https://github.com/Svetlitski/fcp
NEOTERM_PKG_DESCRIPTION="A significantly faster alternative to the classic Unix cp(1) command"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.2.1
NEOTERM_PKG_SRCURL=git+https://github.com/Svetlitski/fcp
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	neoterm_setup_rust
	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/fcp
}
