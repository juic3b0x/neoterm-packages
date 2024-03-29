NEOTERM_PKG_HOMEPAGE=https://github.com/sharkdp/bat
NEOTERM_PKG_DESCRIPTION="A cat(1) clone with wings"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.24.0"
NEOTERM_PKG_SRCURL=https://github.com/sharkdp/bat/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=907554a9eff239f256ee8fe05a922aad84febe4fe10a499def72a4557e9eedfb
NEOTERM_PKG_AUTO_UPDATE=true
# bat calls less with '--RAW-CONTROL-CHARS' which busybox less does not support:
NEOTERM_PKG_DEPENDS="less, libgit2"
NEOTERM_PKG_BUILD_IN_SRC=true
neoterm_step_pre_configure() {
	CPPFLAGS+=" -Dindex=strchr"
	CFLAGS="$CFLAGS $CPPFLAGS"

	# See https://github.com/nagisa/rust_libloading/issues/54
	export CC_x86_64_unknown_linux_gnu=gcc
	export CFLAGS_x86_64_unknown_linux_gnu=""

	neoterm_setup_rust

	: "${CARGO_HOME:=$HOME/.cargo}"
	export CARGO_HOME

	cargo fetch --target "${CARGO_TARGET_NAME}"

	local f
	for f in $CARGO_HOME/registry/src/*/libgit2-sys-*/build.rs; do
		sed -i -E 's/\.range_version\(([^)]*)\.\.[^)]*\)/.atleast_version(\1)/g' "${f}"
	done
}

neoterm_step_post_make_install() {
	mkdir -p $NEOTERM_PREFIX/share/man/man1
	cp $(find . -name bat.1) $NEOTERM_PREFIX/share/man/man1/
}
