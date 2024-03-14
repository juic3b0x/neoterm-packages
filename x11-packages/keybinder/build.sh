NEOTERM_PKG_HOMEPAGE=https://github.com/kupferlauncher/keybinder
NEOTERM_PKG_DESCRIPTION="A library for registering global keyboard shortcuts"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.3.2
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/kupferlauncher/keybinder/releases/download/keybinder-3.0-v${NEOTERM_PKG_VERSION}/keybinder-3.0-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=e6e3de4e1f3b201814a956ab8f16dfc8a262db1937ff1eee4d855365398c6020
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
NEOTERM_PKG_DEPENDS="atk, gdk-pixbuf, glib, gtk3, harfbuzz, libcairo, libx11, libxext, libxrender, pango"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner"
NEOTERM_PKG_DISABLE_GIR=false
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--enable-introspection
"

neoterm_step_pre_configure() {
	neoterm_setup_gir
}
