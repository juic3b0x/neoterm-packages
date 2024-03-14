NEOTERM_PKG_HOMEPAGE=https://github.com/Byron/gitoxide
NEOTERM_PKG_DESCRIPTION="Rust implementation of Git"
NEOTERM_PKG_LICENSE="Apache-2.0, MIT"
NEOTERM_PKG_LICENSE_FILE="LICENSE-APACHE, LICENSE-MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.34.0"
NEOTERM_PKG_SRCURL=https://github.com/Byron/gitoxide/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=5f0686213fa3ad3d6f3adedf3df463dfdb9bb60f9cad03a174ec6b5adba1567f
NEOTERM_PKG_DEPENDS="resolv-conf"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_METHOD=repology
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"

neoterm_step_pre_configure() {
	neoterm_setup_cmake
	neoterm_setup_rust

	: "${CARGO_HOME:=$HOME/.cargo}"
	export CARGO_HOME

	cargo fetch --target "${CARGO_TARGET_NAME}"

	for d in $CARGO_HOME/registry/src/*/trust-dns-resolver-*; do
		sed -e "s|@NEOTERM_PREFIX@|$NEOTERM_PREFIX|" \
			$NEOTERM_PKG_BUILDER_DIR/trust-dns-resolver.diff \
			| patch --silent -p1 -d ${d} || :
	done

	if [ "$NEOTERM_ARCH" == "x86_64" ]; then
		RUSTFLAGS+=" -C link-arg=$($CC -print-libgcc-file-name)"
	fi
}

neoterm_step_make() {
	cargo build \
		--jobs $NEOTERM_MAKE_PROCESSES \
		--target $CARGO_TARGET_NAME \
		--release \
		--no-default-features \
		--features max-pure
}

neoterm_step_make_install() {
	install -Dm755 -t $NEOTERM_PREFIX/bin \
		target/${CARGO_TARGET_NAME}/release/ein \
		target/${CARGO_TARGET_NAME}/release/gix
}
