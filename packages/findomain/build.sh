NEOTERM_PKG_HOMEPAGE=https://findomain.app/
NEOTERM_PKG_DESCRIPTION="Findomain is the fastest subdomain enumerator and the only one written in Rust"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="9.0.4"
NEOTERM_PKG_SRCURL=https://github.com/Findomain/Findomain/archive/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=98c142e2e6ed67726bdea7a1726a54fb6773a8d1ccaa262e008804432af29190
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="resolv-conf"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	neoterm_setup_rust

	# ld: error: undefined symbol: __atomic_is_lock_free
	# ld: error: undefined symbol: __atomic_fetch_or_8
	# ld: error: undefined symbol: __atomic_load
	if [[ "${NEOTERM_ARCH}" == "i686" ]]; then
		RUSTFLAGS+=" -C link-arg=$(${CC} -print-libgcc-file-name)"
	fi

	: "${CARGO_HOME:=$HOME/.cargo}"
	export CARGO_HOME

	cargo fetch --target "${CARGO_TARGET_NAME}"

	for d in $CARGO_HOME/registry/src/*/trust-dns-resolver-*; do
		sed -e "s|@NEOTERM_PREFIX@|$NEOTERM_PREFIX|" \
			$NEOTERM_PKG_BUILDER_DIR/trust-dns-resolver.diff \
			| patch --silent -p1 -d ${d} || :
	done
}
