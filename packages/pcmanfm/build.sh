NEOTERM_PKG_HOMEPAGE=https://sourceforge.net/projects/pcmanfm/
NEOTERM_PKG_DESCRIPTION="Extremely fast and lightweight file manager"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.3.2
NEOTERM_PKG_REVISION=5
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/pcmanfm/pcmanfm-$NEOTERM_PKG_VERSION.tar.xz
NEOTERM_PKG_SHA256=14cb7b247493c4cce65fbb5902611e3ad00a7a870fbc1e50adc50428c5140cf7
NEOTERM_PKG_DEPENDS="atk, glib, gtk3, libcairo, libfm, libx11, lxmenu-data, pango"
NEOTERM_PKG_RECOMMENDS="xarchiver"

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--with-gtk=3
"
