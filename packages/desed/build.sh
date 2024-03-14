NEOTERM_PKG_HOMEPAGE=https://github.com/SoptikHa2/desed
NEOTERM_PKG_DESCRIPTION="Demystifies and debugs your sed scripts"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.2.1
NEOTERM_PKG_SRCURL=https://github.com/SoptikHa2/desed/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=bee8c60d58f11472c036277b0318bdceb5520cce5a61965bc028b26ccbdeb706
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	neoterm_setup_rust
	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/desed
}
