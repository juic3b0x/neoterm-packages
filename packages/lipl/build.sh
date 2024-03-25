NEOTERM_PKG_HOMEPAGE=https://github.com/yxdunc/lipl
NEOTERM_PKG_DESCRIPTION="A command line tool that is similar to watch but has extended functions for commands outputing a number"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.1.3
NEOTERM_PKG_SRCURL=git+https://github.com/yxdunc/lipl
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	neoterm_setup_rust
	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/lipl
}
