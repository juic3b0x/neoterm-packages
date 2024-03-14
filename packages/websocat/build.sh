NEOTERM_PKG_HOMEPAGE=https://github.com/vi/websocat
NEOTERM_PKG_DESCRIPTION="Command-line client for WebSockets, like netcat (or curl) for ws:// with advanced socat-like functions"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.12.0"
NEOTERM_PKG_SRCURL=https://github.com/vi/websocat/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=ca6ab2bc71a9c641fbda7f15d4956f2e19ca32daba9b284d26587410944a3adb
NEOTERM_PKG_DEPENDS="openssl"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
	neoterm_setup_rust

	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

neoterm_step_make_install() {
	install -Dm755 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/websocat
}
