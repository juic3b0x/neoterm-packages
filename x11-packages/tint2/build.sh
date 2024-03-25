NEOTERM_PKG_HOMEPAGE=https://gitlab.com/nick87720z/tint2
NEOTERM_PKG_DESCRIPTION="Lightweight panel, Highly customizable"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=17.1.3
NEOTERM_PKG_SRCURL=https://gitlab.com/nick87720z/tint2/-/archive/v${NEOTERM_PKG_VERSION}/tint2-v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=283e193c3bed452e9d2ecbc64c21303ca3e3cc8a5f0a1e16550cbdae97514a23
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_DEPENDS="gdk-pixbuf, glib, gtk3, imlib2, libandroid-shmem, libandroid-wordexp, libcairo, librsvg, libx11, libxcomposite, libxdamage, libxext, libxinerama, libxrandr, libxrender, pango, startup-notification"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	LDFLAGS+=" -landroid-shmem -landroid-wordexp"
}
