NEOTERM_PKG_HOMEPAGE=https://www.xfce.org/
NEOTERM_PKG_DESCRIPTION="Flexible, easy-to-use configuration management system"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="4.18.3"
NEOTERM_PKG_SRCURL=https://archive.xfce.org/src/xfce/xfconf/${NEOTERM_PKG_VERSION%.*}/xfconf-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=c56cc69056f6947b2c60b165ec1e4c2b0acf26a778da5f86c89ffce24d5ebd98
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="dbus, libxfce4util"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner"
NEOTERM_PKG_DISABLE_GIR=false
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--enable-introspection=yes
--enable-vala=no
"

neoterm_step_pre_configure() {
	NEOTERM_PKG_VERSION=. neoterm_setup_gir
}
