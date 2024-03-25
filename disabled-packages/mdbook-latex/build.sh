NEOTERM_PKG_HOMEPAGE=https://github.com/lbeckman314/mdbook-latex
NEOTERM_PKG_DESCRIPTION="An mdbook backend for generating LaTeX and PDF documents"
NEOTERM_PKG_LICENSE="MPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.1.42
NEOTERM_PKG_SRCURL=https://github.com/lbeckman314/mdbook-latex/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=4b480a79e491a49653104de51d3ee409929093ffef04b2b2c707f09e7ce2e1f8
NEOTERM_PKG_DEPENDS="fontconfig, freetype, harfbuzz, libexpat, libgraphite, libicu, libpng, openssl-1.1, zlib"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	# openssl-sys supports OpenSSL 3 in >= 0.9.69
	export OPENSSL_INCLUDE_DIR=$NEOTERM_PREFIX/include/openssl-1.1
	export OPENSSL_LIB_DIR=$NEOTERM_PREFIX/lib/openssl-1.1
	CFLAGS="-I$NEOTERM_PREFIX/include/openssl-1.1 $CFLAGS"
	CPPFLAGS="-I$NEOTERM_PREFIX/include/openssl-1.1 $CPPFLAGS"
	CXXFLAGS="-I$NEOTERM_PREFIX/include/openssl-1.1 $CXXFLAGS"
	LDFLAGS="-L$NEOTERM_PREFIX/lib/openssl-1.1 -Wl,-rpath=$NEOTERM_PREFIX/lib/openssl-1.1 $LDFLAGS"
	RUSTFLAGS+=" -C link-arg=-Wl,-rpath=$NEOTERM_PREFIX/lib/openssl-1.1"

	neoterm_setup_rust

	: "${CARGO_HOME:=$HOME/.cargo}"
	export CARGO_HOME

	cargo fetch --target "${CARGO_TARGET_NAME}"

	local c
	for c in {expat,servo-{fontconfig,freetype}}-sys; do
		local p=$NEOTERM_PKG_BUILDER_DIR/${c}-build.rs.diff
		local d
		for d in $CARGO_HOME/registry/src/github.com-*/${c}-*; do
			patch --silent -p1 -d ${d} < ${p} || :
		done
	done

	local d
	for d in $CARGO_HOME/registry/src/github.com-*/usvg-*; do
		sed 's|@NEOTERM_PREFIX@|'"${NEOTERM_PREFIX}"'|g' \
			$NEOTERM_PKG_BUILDER_DIR/usvg-src-fontdb.rs.diff \
			| patch --silent -p1 -d ${d} || :
	done

	local _patch=$NEOTERM_PKG_BUILDER_DIR/mdbook-src-renderer-html_handlebars-helpers-navigation.rs.diff
	for d in $CARGO_HOME/registry/src/github.com-*/mdbook-*; do
		patch --silent -p1 -d ${d} < ${_patch} || :
	done
}

neoterm_step_make() {
	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/mdbook-latex
}
