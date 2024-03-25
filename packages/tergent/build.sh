NEOTERM_PKG_HOMEPAGE=https://github.com/aeolwyr/tergent
NEOTERM_PKG_DESCRIPTION="A cryptoki/PKCS#11 library for NeoTerm that uses Android Keystore as its backend"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.0.0
NEOTERM_PKG_REVISION=4
# Build from specific revision until patches are merged upstream, or
# we decide to maintain a fork
_COMMIT=831e300e3d75a9618963bbefbaad49bf37e2cf3c
NEOTERM_PKG_SRCURL=https://github.com/neoterm/tergent/archive/${_COMMIT}.tar.gz
NEOTERM_PKG_SHA256=8979504a0e705fca35a6ae81ba1665c5bafebe218008ee50b6dc4f8a8d611cec
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_DEPENDS="neoterm-api"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	neoterm_setup_rust
}

neoterm_step_make() {
	local BUILD_TYPE=
	if [ $NEOTERM_DEBUG_BUILD = false ]; then
		BUILD_TYPE=--release
	fi

	cargo build --jobs $NEOTERM_MAKE_PROCESSES \
		--target $CARGO_TARGET_NAME ${BUILD_TYPE}
}

neoterm_step_make_install() {
	local BUILD_TYPE=release
	if [ $NEOTERM_DEBUG_BUILD = true ]; then
		BUILD_TYPE=debug
	fi
	install -Dm600 -t $NEOTERM_PREFIX/lib \
		target/${CARGO_TARGET_NAME}/${BUILD_TYPE}/libtergent.so
}
