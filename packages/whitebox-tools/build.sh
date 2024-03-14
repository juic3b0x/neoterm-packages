NEOTERM_PKG_HOMEPAGE="https://github.com/jblindsay/whitebox-tools"
NEOTERM_PKG_DESCRIPTION="An advanced geospatial data analysis platform"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.3.0"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL="https://github.com/jblindsay/whitebox-tools/archive/refs/tags/v2.0.0.tar.gz"
NEOTERM_PKG_SHA256=18705fc948bdb2f96cd816e5a72d36b9cc460aa8c910383d23fdbd61641aab60
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	neoterm_setup_rust
	cargo update # Fix rust 1.73 incompatibility - can probably be removed when bumping version
	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin/whitebox_tools  \
		target/${CARGO_TARGET_NAME}/release/whitebox_tools
}
