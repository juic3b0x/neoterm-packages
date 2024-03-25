NEOTERM_PKG_HOMEPAGE=https://github.com/facebookincubator/below
NEOTERM_PKG_DESCRIPTION="An interactive tool to view and record historical system data"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.7.1
NEOTERM_PKG_SRCURL=https://github.com/facebookincubator/below/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=9b70d010189e8d343dc67b730a1d8eeb0e1d19805688e4f70662e216fb4cd6b5
NEOTERM_PKG_DEPENDS="libelf, zlib"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"

# ```
# error[E0308]: mismatched types
#    --> /home/builder/.cargo/registry/src/github.com-1ecc6299db9ec823/openat-0.1.21/src/dir.rs:465:34
#     |
# 465 |             match stat.st_mode & libc::S_IFMT {
#     |                                  ^^^^^^^^^^^^ expected `u32`, found `u16`
# ```
NEOTERM_PKG_BLACKLISTED_ARCHES="arm, i686"

neoterm_step_pre_configure() {
	neoterm_setup_rust
	: "${CARGO_HOME:=$HOME/.cargo}"
	export CARGO_HOME

	cargo fetch --target $CARGO_TARGET_NAME

	local d p
	for d in $CARGO_HOME/registry/src/*/libbpf-sys-*; do
		for p in libbpf-sys-0.6.0-1-libbpf-include-linux-{compiler,types}.h.diff; do
			patch --silent -p1 -d ${d} \
				< "$NEOTERM_PKG_BUILDER_DIR/${p}" || :
		done
	done
	for d in $CARGO_HOME/registry/src/*/nix-*; do
		for p in nix-{0.22.0,0.23.1}-src-sys-statfs.rs.diff; do
			patch --silent -p1 -d ${d} \
				< "$NEOTERM_PKG_BUILDER_DIR/${p}" || :
		done
	done

	local _CARGO_TARGET_LIBDIR=target/$CARGO_TARGET_NAME/release/deps
	mkdir -p $_CARGO_TARGET_LIBDIR
	local lib
	for lib in lib{elf,z}.so; do
		ln -sf $NEOTERM_PREFIX/lib/${lib} $_CARGO_TARGET_LIBDIR/
	done

	if [ "$NEOTERM_ON_DEVICE_BUILD" = "false" ]; then
		export CLANG=/usr/bin/clang-15
	fi
}

neoterm_step_make() {
	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/below
}
