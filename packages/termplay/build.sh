NEOTERM_PKG_HOMEPAGE=https://gitlab.com/jD91mZM2/termplay
NEOTERM_PKG_DESCRIPTION="Plays an image/video in your terminal"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.0.6
NEOTERM_PKG_SRCURL=https://gitlab.com/jD91mZM2/termplay/-/archive/v${NEOTERM_PKG_VERSION}/termplay-v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=fba29bf75640c698079b22eeb05e3fdc81c8abc7b232bd9b6752f267aa5405e0
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_DEPENDS="glib, gst-plugins-base, gstreamer, libsixel"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	neoterm_setup_rust
	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release \
		--features bin
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/termplay
}
