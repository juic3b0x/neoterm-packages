NEOTERM_PKG_HOMEPAGE=https://www.nushell.sh
NEOTERM_PKG_DESCRIPTION="A new type of shell operating on structured data"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.91.0"
NEOTERM_PKG_SRCURL=https://github.com/nushell/nushell/archive/$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=8957808c3d87b17c6e874b8382e8be45100e83c540556b2c43864c428c2b80b5
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="openssl, zlib"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS=("--no-default-features")

neoterm_step_pre_configure() {
	neoterm_setup_rust

	local _CARGO_TARGET_LIBDIR="target/${CARGO_TARGET_NAME}/release/deps"
	mkdir -p $_CARGO_TARGET_LIBDIR

	if [ $NEOTERM_ARCH = "i686" ]; then
		RUSTFLAGS+=" -C link-arg=-latomic"
	elif [ $NEOTERM_ARCH = "x86_64" ]; then
		pushd $_CARGO_TARGET_LIBDIR
		RUSTFLAGS+=" -C link-arg=$($CC -print-libgcc-file-name)"
		echo "INPUT(-l:libunwind.a)" >libgcc.so
		popd
	fi

	local _features="default-no-clipboard extra"
	if [ $NEOTERM_ARCH != "i686" ] && [ $NEOTERM_ARCH != "arm" ]; then
		_features+=" dataframe"
	fi
	NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=("--features=$_features")

	: "${CARGO_HOME:=$HOME/.cargo}"
	export CARGO_HOME

	cargo fetch --target "${CARGO_TARGET_NAME}"

	mv $NEOTERM_PREFIX/lib/libz.so.1{,.tmp}
	mv $NEOTERM_PREFIX/lib/libz.so{,.tmp}

	ln -sfT $(readlink -f $NEOTERM_PREFIX/lib/libz.so.1.tmp) \
		$_CARGO_TARGET_LIBDIR/libz.so.1
	ln -sfT $(readlink -f $NEOTERM_PREFIX/lib/libz.so.tmp) \
		$_CARGO_TARGET_LIBDIR/libz.so
}

neoterm_step_make_install() {
	cargo install \
			--path . \
			--jobs $NEOTERM_MAKE_PROCESSES \
			--no-track \
			--target $CARGO_TARGET_NAME \
			--root $NEOTERM_PREFIX \
			"${NEOTERM_PKG_EXTRA_CONFIGURE_ARGS[@]}"
}

neoterm_step_post_make_install() {
	mv $NEOTERM_PREFIX/lib/libz.so.1{.tmp,}
	mv $NEOTERM_PREFIX/lib/libz.so{.tmp,}
}

neoterm_step_post_massage() {
	rm -f lib/libz.so.1
	rm -f lib/libz.so
}
