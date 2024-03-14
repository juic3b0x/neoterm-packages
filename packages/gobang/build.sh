NEOTERM_PKG_HOMEPAGE="https://github.com/TaKO8Ki/gobang"
NEOTERM_PKG_DESCRIPTION="A cross-platform TUI database management tool written in Rust"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.1.0-alpha.5"
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL="https://github.com/TaKO8Ki/gobang/archive/refs/tags/v$NEOTERM_PKG_VERSION.tar.gz"
NEOTERM_PKG_SHA256=923210d500f070ac862c73d1a43a10520ee8c54f6692bbce99bbd073dfa72653
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	neoterm_setup_rust

	cargo update

	if [ "$NEOTERM_ARCH" = "x86_64" ]; then
		local libdir=target/$CARGO_TARGET_NAME/release/deps
		mkdir -p $libdir
		pushd $libdir
		RUSTFLAGS+=" -C link-arg=$($CC -print-libgcc-file-name)"
		echo "INPUT(-l:libunwind.a)" > libgcc.so
		popd
	fi
}
