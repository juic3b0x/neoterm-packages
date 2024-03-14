NEOTERM_PKG_HOMEPAGE=https://github.com/Canop/broot
NEOTERM_PKG_DESCRIPTION="A better way to navigate directories"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.36.1"
NEOTERM_PKG_SRCURL=https://github.com/Canop/broot/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=b52e60a86e3ca38931cf8ed0ccbd4138f12b733c2459ea3088c267a98b8a555b
NEOTERM_PKG_DEPENDS="libgit2"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_pre_configure() {
	neoterm_setup_rust

	: "${CARGO_HOME:=$HOME/.cargo}"
	export CARGO_HOME

	cargo fetch --target "${CARGO_TARGET_NAME}"

	local f
	for f in $CARGO_HOME/registry/src/*/libgit2-sys-*/build.rs; do
		sed -i -E 's/\.range_version\(([^)]*)\.\.[^)]*\)/.atleast_version(\1)/g' "${f}"
	done
	sed -i '/trash/d' $NEOTERM_PKG_SRCDIR/Cargo.toml
}

neoterm_step_make() {
	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release

	mkdir -p build
	cp man/page build/broot.1
	sed -i "s/#version/$NEOTERM_PKG_VERSION/g" build/broot.1
	sed -i "s/#date/$(date -r man/page +'%Y\/%m\/%d')/g" build/broot.1

}

neoterm_step_make_install() {
	install -Dm755 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/broot
	install -Dm644 -t $NEOTERM_PREFIX/share/man/man1 build/broot.1
}
