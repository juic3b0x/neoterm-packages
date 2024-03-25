NEOTERM_PKG_HOMEPAGE=https://github.com/dalance/procs
NEOTERM_PKG_DESCRIPTION="A modern replacement for ps"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.14.5"
NEOTERM_PKG_SRCURL=https://github.com/dalance/procs/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=539b88565c775a106063da5cc5148cfdc7e010534f3dbc90cb8f6317d51ca96b
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

# This package contains makefiles to run the tests. So, we need to override build steps.
neoterm_step_make() {
	neoterm_setup_rust
	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/procs
}
