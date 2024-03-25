NEOTERM_PKG_HOMEPAGE=https://elkowar.github.io/eww/
NEOTERM_PKG_DESCRIPTION="ElKowars wacky widgets"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.5.0"
NEOTERM_PKG_SRCURL=git+https://github.com/elkowar/eww
NEOTERM_PKG_DEPENDS="glib, gtk3, gtk-layer-shell, pango, gdk-pixbuf, libcairo"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
	neoterm_setup_rust
	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/eww
}
