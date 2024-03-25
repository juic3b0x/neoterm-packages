NEOTERM_PKG_HOMEPAGE=https://github.com/sytsereitsma/mdbook-plantuml
NEOTERM_PKG_DESCRIPTION="mdBook preprocessor to render PlantUML code blocks as images in your book"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.8.0
NEOTERM_PKG_SRCURL=git+https://github.com/sytsereitsma/mdbook-plantuml
NEOTERM_PKG_DEPENDS="openssl-1.1"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
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
	install -Dm700 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/mdbook-plantuml
}
