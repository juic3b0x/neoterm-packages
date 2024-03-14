NEOTERM_PKG_HOMEPAGE=https://github.com/nivekuil/rip
NEOTERM_PKG_DESCRIPTION="A command-line deletion tool focused on safety, ergonomics, and performance"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.13.1
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=git+https://github.com/nivekuil/rip
NEOTERM_PKG_GIT_BRANCH="${NEOTERM_PKG_VERSION}"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	neoterm_setup_rust
	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/rip
}
