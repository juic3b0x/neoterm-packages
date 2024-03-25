NEOTERM_PKG_HOMEPAGE=https://github.com/denisidoro/navi
NEOTERM_PKG_DESCRIPTION="An interactive cheatsheet tool for the command-line"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.23.0"
NEOTERM_PKG_SRCURL=https://github.com/denisidoro/navi/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=579a72814e7ba07dae697a58dc13b0f7d853532ec07229aff07a11e5828f3799
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="fzf, git"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	rm -f Makefile
}

neoterm_step_make_install() {
	neoterm_setup_rust
	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
	install -Dm755 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/navi
}
