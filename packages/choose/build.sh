NEOTERM_PKG_HOMEPAGE=https://github.com/theryangeary/choose
NEOTERM_PKG_DESCRIPTION="A human-friendly and fast alternative to cut and (sometimes) awk"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.3.4
NEOTERM_PKG_SRCURL=git+https://github.com/theryangeary/choose
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	neoterm_setup_rust
	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/choose
}
