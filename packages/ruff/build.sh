NEOTERM_PKG_HOMEPAGE="https://github.com/charliermarsh/ruff"
NEOTERM_PKG_DESCRIPTION="An extremely fast Python linter, written in Rust"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_LICENSE_FILE="../../LICENSE"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.3.0"
NEOTERM_PKG_SRCURL="https://github.com/charliermarsh/ruff/archive/refs/tags/v$NEOTERM_PKG_VERSION.tar.gz"
NEOTERM_PKG_SHA256=4b65339c295e30cbe50a9848eae45be2c4771cf4de7b22d9ed6ac016002ceca5
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	NEOTERM_PKG_SRCDIR+="/crates/ruff"
	NEOTERM_PKG_BUILDDIR="${NEOTERM_PKG_SRCDIR}"

	cd $NEOTERM_PKG_BUILDDIR
	rm -rf _lib
	mkdir -p _lib
	cd _lib
	$CC $CPPFLAGS $CFLAGS -fvisibility=hidden \
		-c $NEOTERM_PKG_BUILDER_DIR/ctermid.c 
	$AR cru libctermid.a ctermid.o

	RUSTFLAGS+=" -C link-arg=$NEOTERM_PKG_BUILDDIR/_lib/libctermid.a"

	neoterm_setup_rust

	: "${CARGO_HOME:=$HOME/.cargo}"
	export CARGO_HOME

	cd $NEOTERM_PKG_SRCDIR
	cargo fetch --target "${CARGO_TARGET_NAME}"

	local _patch=$NEOTERM_PKG_BUILDER_DIR/tikv-jemalloc-sys-0.5.3+5.3.0-patched-src-lib.rs.diff
	local d
	for d in $CARGO_HOME/registry/src/*/tikv-jemalloc-sys-*; do
		patch --silent -p1 -d ${d} < ${_patch} || :
	done
}
