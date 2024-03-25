NEOTERM_PKG_HOMEPAGE=https://sourceforge.net/projects/lxde/
NEOTERM_PKG_DESCRIPTION="Caching mechanism for freedesktop.org compliant menus"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.1.0
NEOTERM_PKG_REVISION=26
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/lxde/menu-cache-$NEOTERM_PKG_VERSION.tar.xz
NEOTERM_PKG_SHA256=ed02eb459dcb398f69b9fa5bf4dd813020405afc84331115469cdf7be9273ec7
NEOTERM_PKG_DEPENDS="glib, libfm-extra"

neoterm_step_pre_configure() {
	CFLAGS+=" -fcommon"
}
