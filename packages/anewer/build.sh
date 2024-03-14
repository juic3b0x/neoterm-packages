NEOTERM_PKG_HOMEPAGE="https://github.com/ysf/anewer"
NEOTERM_PKG_DESCRIPTION="Append lines from stdin to a file if these lines do not present in that file (aHash-based uniq)"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@flosnvjx"
NEOTERM_PKG_VERSION="0.1.6"
NEOTERM_PKG_SRCURL="https://github.com/ysf/anewer/archive/refs/tags/$NEOTERM_PKG_VERSION.tar.gz"
NEOTERM_PKG_SHA256=0f7d85dcba7cee291f63b8475a74806d385be768a43c2bf039fc32198026d918
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
	neoterm_setup_rust
	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release --locked
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/anewer
	install -Dm600 -t $NEOTERM_PREFIX/share/doc/$NEOTERM_PKG_NAME README.*
}
