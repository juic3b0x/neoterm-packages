NEOTERM_PKG_HOMEPAGE=https://github.com/lsd-rs/lsd 
NEOTERM_PKG_DESCRIPTION="Next gen ls command"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="Krishna Kanhaiya @kcubeterm"
NEOTERM_PKG_VERSION="1.0.0"
NEOTERM_PKG_SRCURL=https://github.com/lsd-rs/lsd/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=ab34e9c85bc77cfa42b43bfb54414200433a37419f3b1947d0e8cfbb4b7a6325
NEOTERM_PKG_DEPENDS="zlib"
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	neoterm_setup_rust

	mv $NEOTERM_PREFIX/lib/libz.so.1{,.tmp}
	mv $NEOTERM_PREFIX/lib/libz.so{,.tmp}

	local _CARGO_TARGET_LIBDIR="target/${CARGO_TARGET_NAME}/release/deps"
	mkdir -p "${_CARGO_TARGET_LIBDIR}"

	ln -sfT "$(readlink -f "${NEOTERM_PREFIX}"/lib/libz.so.1.tmp)" \
		"${_CARGO_TARGET_LIBDIR}"/libz.so.1
	ln -sfT "$(readlink -f "${NEOTERM_PREFIX}"/lib/libz.so.tmp)" \
		"${_CARGO_TARGET_LIBDIR}"/libz.so
}

neoterm_step_post_make_install() {
	mv $NEOTERM_PREFIX/lib/libz.so.1{.tmp,}
	mv $NEOTERM_PREFIX/lib/libz.so{.tmp,}
}

neoterm_step_post_massage() {
	rm -f lib/libz.so.1
	rm -f lib/libz.so
}
