NEOTERM_PKG_HOMEPAGE=https://github.com/loichyan/nerdfix
NEOTERM_PKG_DESCRIPTION="nerdfix helps you to find/fix obsolete Nerd Font icons in your project."
NEOTERM_PKG_LICENSE="Apache-2.0, MIT"
NEOTERM_PKG_MAINTAINER="Joshua Kahn @TomJo2000"
NEOTERM_PKG_VERSION=0.4.0
NEOTERM_PKG_SRCURL=https://github.com/loichyan/nerdfix/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=72e835aeb349495be87e92f74f405b43dac982ec137cfd7e180e72146b6f6fb7
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	# do not pin the version of the rust toolchain
	rm -f rust-toolchain
	neoterm_setup_rust
}

neoterm_step_make() {
	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

neoterm_step_make_install() {
	install -Dm755 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/nerdfix
}

