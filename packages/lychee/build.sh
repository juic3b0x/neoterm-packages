NEOTERM_PKG_HOMEPAGE=https://github.com/lycheeverse/lychee
NEOTERM_PKG_DESCRIPTION="A fast, async, resource-friendly link checker written in Rust"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_LICENSE_FILE="LICENSE-MIT, LICENSE-APACHE"
NEOTERM_PKG_MAINTAINER="Yaksh Bariya <thunder-coding@neoterm.dev>"
NEOTERM_PKG_VERSION="0.14.3"
NEOTERM_PKG_SRCURL=https://github.com/lycheeverse/lychee/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=b2ce1bd57040ab9d1719b9540e8c2905327f6a71674a0e5f2297f00bb4410651
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="openssl, resolv-conf"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	neoterm_setup_rust

	: "${CARGO_HOME:=$HOME/.cargo}"
	export CARGO_HOME

	cargo fetch --target "${CARGO_TARGET_NAME}"

	for d in $CARGO_HOME/registry/src/*/trust-dns-resolver-*; do
		sed -e "s|@NEOTERM_PREFIX@|$NEOTERM_PREFIX|" \
			$NEOTERM_PKG_BUILDER_DIR/trust-dns-resolver.diff \
			| patch --silent -p1 -d ${d} || :
	done
}

neoterm_step_make() {
	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

neoterm_step_make_install() {
	install -Dm755 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/lychee
}
