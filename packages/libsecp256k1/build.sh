NEOTERM_PKG_HOMEPAGE=https://github.com/bitcoin-core/secp256k1
NEOTERM_PKG_DESCRIPTION="Optimized c library for ECDSA signatures and seret/public key operations on curve secp256k1"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1:0.4.1"
NEOTERM_PKG_SRCURL=https://github.com/bitcoin-core/secp256k1/archive/refs/tags/v${NEOTERM_PKG_VERSION#*:}.tar.gz
NEOTERM_PKG_SHA256=31b1a03c7365dbce7aff4be9526243da966c58a8b88b6255556d51b3016492c5
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

# These flags are suggested by electrum
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--enable-module-recovery
--enable-experimental
--enable-module-ecdh
"

neoterm_step_pre_configure() {
	autoreconf -vfi
}
