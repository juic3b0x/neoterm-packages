NEOTERM_PKG_HOMEPAGE=https://github.com/extrawurst/gitui
NEOTERM_PKG_DESCRIPTION="Blazing fast terminal-ui for git written in rust"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_LICENSE_FILE="LICENSE.md"
NEOTERM_PKG_MAINTAINER="@PeroSar"
NEOTERM_PKG_VERSION="0.25.1"
NEOTERM_PKG_SRCURL=https://github.com/extrawurst/gitui/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=78d31ba66de1521477aef1642c798a385106ff4858f59e79775ba08a694d0ae4
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="git, libgit2, libssh2, openssl"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	CPPFLAGS+=" -Dindex=strchr"
	export OPENSSL_NO_VENDOR=1
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
}

neoterm_step_make() {
	cargo build --release \
		--jobs "$NEOTERM_MAKE_PROCESSES" \
		--target "$CARGO_TARGET_NAME" \
		--locked
}

neoterm_step_make_install() {
	install -Dm700 target/"${CARGO_TARGET_NAME}"/release/gitui "$NEOTERM_PREFIX"/bin/
}
