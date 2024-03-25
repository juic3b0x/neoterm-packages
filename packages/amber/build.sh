NEOTERM_PKG_HOMEPAGE=https://github.com/dalance/amber
NEOTERM_PKG_DESCRIPTION="A code search / replace tool"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.6.0
NEOTERM_PKG_SRCURL=https://github.com/dalance/amber/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=41908502077197f55ec86b3a4dd4059a78deae9833e9ba33302b1146cc1ec3f5
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_REPLACES="amr, ambs"
NEOTERM_PKG_BREAKS="amr, ambs"
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
	neoterm_setup_rust

	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/ambr
	install -Dm700 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/ambs
}
