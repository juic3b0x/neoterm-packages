NEOTERM_PKG_HOMEPAGE=https://github.com/mozilla/sccache
NEOTERM_PKG_DESCRIPTION="sccache is ccache with cloud storage"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.7.7"
NEOTERM_PKG_SRCURL=https://github.com/mozilla/sccache/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=a5f5dacbc8232d566239fa023ce5fbc803ad56af2910fa1558b6e08e68e067e0
NEOTERM_PKG_DEPENDS="openssl"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
	neoterm_setup_rust
	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/sccache
}
