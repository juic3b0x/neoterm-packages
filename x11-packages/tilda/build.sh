NEOTERM_PKG_HOMEPAGE=https://github.com/lanoxx/tilda
NEOTERM_PKG_DESCRIPTION="A Gtk based drop down terminal for Linux and Unix."
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@ELWAER-M"
NEOTERM_PKG_VERSION="1.6-alpha"
NEOTERM_PKG_REVISION=7
NEOTERM_PKG_SRCURL=https://github.com/lanoxx/tilda/archive/a8f70a8b9300992dc13185112a251b90850fd96e.tar.gz
NEOTERM_PKG_SHA256=83c3bdccd9f41183cf656c11f925cf383f7cf0cbafbd56f51d8a1e2983bb7739
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_DEPENDS="glib, gtk3, libvte, libconfuse, libx11, gettext"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	NOCONFIGURE=1 ./autogen.sh
}
