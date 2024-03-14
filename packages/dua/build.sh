NEOTERM_PKG_HOMEPAGE=https://github.com/Byron/dua-cli
NEOTERM_PKG_DESCRIPTION="View disk space usage and delete unwanted data, fast"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="SunPodder <contact.sunpodder09@gmail.com>"
NEOTERM_PKG_VERSION="2.29.0"
NEOTERM_PKG_SRCURL=https://github.com/Byron/dua-cli/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=af58bfc5146b296ced1ed711b0bbd21bce731a69fb6bea6622e6acfbe180a91a
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	neoterm_setup_rust
}

neoterm_step_make() {
	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release --no-default-features --features tui-crossplatform
}

neoterm_step_make_install() {
	install -Dm755 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/dua
}

