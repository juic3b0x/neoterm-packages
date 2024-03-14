NEOTERM_PKG_HOMEPAGE=https://github.com/sigoden/aichat
NEOTERM_PKG_DESCRIPTION="A powerful chatgpt cli"
NEOTERM_PKG_LICENSE="Apache-2.0,MIT"
NEOTERM_PKG_LICENSE_FILE="LICENSE-APACHE,LICENSE-MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.14.0"
NEOTERM_PKG_SRCURL=https://github.com/sigoden/aichat/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=de554ef95d75a17b20f384b5f2ea07b3d2cd6112e87e9e038145d13285633468
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

# This package contains makefiles to run the tests. So, we need to override build steps.
neoterm_step_make() {
	neoterm_setup_rust
	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/aichat
}
