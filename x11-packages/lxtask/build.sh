NEOTERM_PKG_HOMEPAGE=http://www.lxde.org/
NEOTERM_PKG_DESCRIPTION="LXTask is a GUI application for the Lightweight X11 Desktop Environment (LXDE)"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="Yisus7u7 <dev.yisus@hotmail.com>"
NEOTERM_PKG_VERSION=0.1.10
NEOTERM_PKG_REVISION=4
NEOTERM_PKG_SRCURL=https://github.com/lxde/lxtask/archive/refs/tags/$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=a3ea7f983396d816d8057eea8974e3cc12a870e658f71e15dec41c863e50f5d9
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_DEPENDS="gtk3, glib"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--enable-gtk3"
neoterm_step_pre_configure() {
	./autogen.sh
}
