NEOTERM_PKG_HOMEPAGE=https://github.com/tfenne/pipebuffer
NEOTERM_PKG_DESCRIPTION="Arbitrary-sized in-memory buffer between pipelined programs (non-blocking mbuffer analogue for pipeline)"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.0.git20211120"
NEOTERM_PKG_SRCURL=https://github.com/tfenne/pipebuffer/archive/9af1e18b38b9a62b054047e4131d4077cce101ae.tar.gz
NEOTERM_PKG_SHA256=cc73135fa4f3bec90ab762271122dd7671bfc9f664a9c4bda9734b661372ac6d
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	neoterm_setup_rust
	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

neoterm_step_make_install() {
	install -vDm700 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/pipebuffer
	mkdir -vp $NEOTERM_PREFIX/share/doc/$NEOTERM_PKG_NAME
	install -vpm600 -t $NEOTERM_PREFIX/share/doc/$NEOTERM_PKG_NAME README.*
}
