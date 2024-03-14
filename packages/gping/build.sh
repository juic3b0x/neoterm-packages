NEOTERM_PKG_HOMEPAGE=https://github.com/orf/gping
NEOTERM_PKG_DESCRIPTION="Ping, but with a graph"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="Krishna kanhaiya @kcubeterm"
NEOTERM_PKG_VERSION="1.16.1"
NEOTERM_PKG_SRCURL=https://github.com/orf/gping/archive/refs/tags/gping-v$NEOTERM_PKG_VERSION.zip
NEOTERM_PKG_SHA256=aba2df11bf7eefc9666b1b950b8efe1378dbc795b5e9dbe852bbc6c80e6fadbe
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
NEOTERM_PKG_BUILD_DEPENDS="zlib"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	neoterm_setup_rust

	mv $NEOTERM_PREFIX/lib/libz.so.1{,.tmp}
	mv $NEOTERM_PREFIX/lib/libz.so{,.tmp}
}

neoterm_step_make() {
	cd gping
	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
	cd ..
}

neoterm_step_make_install() {
	install -Dm755 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/gping
}

neoterm_step_post_make_install() {
	mv $NEOTERM_PREFIX/lib/libz.so.1{.tmp,}
	mv $NEOTERM_PREFIX/lib/libz.so{.tmp,}
}

neoterm_step_post_massage() {
	rm -f lib/libz.so.1
	rm -f lib/libz.so
}
