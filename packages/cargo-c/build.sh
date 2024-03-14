NEOTERM_PKG_HOMEPAGE=https://github.com/lu-zero/cargo-c
NEOTERM_PKG_DESCRIPTION="Cargo C-ABI helpers"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.9.30"
NEOTERM_PKG_SRCURL=https://github.com/lu-zero/cargo-c/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=174cfc3a69263c3e54b95e00c4bd61b13377f7f72d4bf60aa714fd9e7ed3849c
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libcurl, libgit2, libssh2, openssl, zlib"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	export LIBGIT2_SYS_USE_PKG_CONFIG=1
	export LIBSSH2_SYS_USE_PKG_CONFIG=1
	export PKG_CONFIG_ALLOW_CROSS=1

	neoterm_setup_rust

	: "${CARGO_HOME:=$HOME/.cargo}"
	export CARGO_HOME

	cargo fetch --target "${CARGO_TARGET_NAME}"

	local f
	for f in $CARGO_HOME/registry/src/*/libgit2-sys-*/build.rs; do
		sed -i -E 's/\.range_version\(([^)]*)\.\.[^)]*\)/.atleast_version(\1)/g' "${f}"
	done

	local _CARGO_TARGET_LIBDIR="target/${CARGO_TARGET_NAME}/release/deps"
	mkdir -p $_CARGO_TARGET_LIBDIR

	mv $NEOTERM_PREFIX/lib/libz.so.1{,.tmp}
	mv $NEOTERM_PREFIX/lib/libz.so{,.tmp}

	ln -sfT $(readlink -f $NEOTERM_PREFIX/lib/libz.so.1.tmp) \
		$_CARGO_TARGET_LIBDIR/libz.so.1
	ln -sfT $(readlink -f $NEOTERM_PREFIX/lib/libz.so.tmp) \
		$_CARGO_TARGET_LIBDIR/libz.so

	if [[ "${NEOTERM_ARCH}" == "x86_64" ]]; then
		RUSTFLAGS+=" -C link-arg=$($CC -print-libgcc-file-name)"
	fi
}

neoterm_step_post_make_install() {
	mv $NEOTERM_PREFIX/lib/libz.so.1{.tmp,}
	mv $NEOTERM_PREFIX/lib/libz.so{.tmp,}
}

neoterm_step_post_massage() {
	rm -f lib/libz.so.1
	rm -f lib/libz.so
}
