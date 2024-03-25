NEOTERM_PKG_HOMEPAGE=https://age-encryption.org/v1
NEOTERM_PKG_DESCRIPTION="A simple, secure and modern encryption tool"
NEOTERM_PKG_LICENSE="Apache-2.0, MIT"
NEOTERM_PKG_LICENSE_FILE="LICENSE-APACHE, LICENSE-MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.10.0"
NEOTERM_PKG_SRCURL=https://github.com/str4d/rage/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=34c39c28f8032c144a43aea96e58159fe69526f5ff91cb813083530adcaa6ea4
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
	neoterm_setup_rust

	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

neoterm_step_make_install() {
	install -Dm755 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/rage
	install -Dm755 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/rage-keygen
}
