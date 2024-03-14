NEOTERM_PKG_HOMEPAGE=https://github.com/EFForg/apkeep
NEOTERM_PKG_DESCRIPTION="A command-line tool for downloading APK files from various sources"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.15.0"
NEOTERM_PKG_SRCURL=https://github.com/EFForg/apkeep/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=439815cc2eb75df1235bb1106135548af2465e47486df6d1742cd47c0bd687dc
NEOTERM_PKG_DEPENDS="openssl (>= 3.0.3)"
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	export OPENSSL_INCLUDE_DIR=$NEOTERM_PREFIX/include/openssl
	export OPENSSL_LIB_DIR=$NEOTERM_PREFIX/lib
}

neoterm_step_make() {
	neoterm_setup_rust
	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

neoterm_step_make_install() {
	install -Dm755 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/apkeep
}
