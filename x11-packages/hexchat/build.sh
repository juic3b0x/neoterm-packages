NEOTERM_PKG_HOMEPAGE=https://hexchat.github.io/
NEOTERM_PKG_DESCRIPTION="A popular and easy to use graphical IRC (chat) client"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.16.1
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/hexchat/hexchat/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=f15bc487312a96a902e042e8f197a8494a29bcf4a00bbfd276a5e8154263bfe5
NEOTERM_PKG_DEPENDS="gdk-pixbuf, glib, gtk2, liblua53, libx11, openssl, pango, python"
NEOTERM_PKG_PYTHON_COMMON_DEPS="cffi"

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dlibcanberra=disabled
-Ddbus=disabled
-Dwith-lua=lua53
-Dtext-frontend=true
-Dwith-perl=false
-Dwith-sysinfo=false
"

NEOTERM_PKG_RM_AFTER_INSTALL="share/locale"
