NEOTERM_PKG_HOMEPAGE=https://github.com/lise-henry
NEOTERM_PKG_DESCRIPTION="Allows you to write a book in Markdown without worrying about formatting or typography"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.16.1"
NEOTERM_PKG_SRCURL=https://github.com/lise-henry/crowbook/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=2e49a10f1b14666d4f740e9a22a588d44b137c3fca0932afc50ded0280450311
NEOTERM_PKG_DEPENDS="openssl-1.1"
NEOTERM_PKG_BUILD_IN_SRC=true

# https://github.com/juic3b0x/neoterm-packages/issues/12824
NEOTERM_RUST_VERSION=1.73.0

neoterm_step_pre_configure() {
	# openssl-sys supports OpenSSL 3 in >= 0.9.69
	# We can switch to OpenSSL 3 once new version of crowbook is released
	export OPENSSL_INCLUDE_DIR=$NEOTERM_PREFIX/include/openssl-1.1
	export OPENSSL_LIB_DIR=$NEOTERM_PREFIX/lib/openssl-1.1
	CFLAGS="-I$NEOTERM_PREFIX/include/openssl-1.1 $CFLAGS"
	CPPFLAGS="-I$NEOTERM_PREFIX/include/openssl-1.1 $CPPFLAGS"
	CXXFLAGS="-I$NEOTERM_PREFIX/include/openssl-1.1 $CXXFLAGS"
	LDFLAGS="-L$NEOTERM_PREFIX/lib/openssl-1.1 -Wl,-rpath=$NEOTERM_PREFIX/lib/openssl-1.1 $LDFLAGS"
	RUSTFLAGS+=" -C link-arg=-Wl,-rpath=$NEOTERM_PREFIX/lib/openssl-1.1"
}

neoterm_step_make() {
	neoterm_setup_rust
	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/crowbook
}
