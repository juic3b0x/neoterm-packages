## This is stripped down version of 'libfm' package.
## Primarily used for compiling 'menu-cache'.

NEOTERM_PKG_HOMEPAGE=https://sourceforge.net/projects/pcmanfm/
NEOTERM_PKG_DESCRIPTION="Extra library for file management"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.3.2
NEOTERM_PKG_REVISION=4
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/pcmanfm/libfm-$NEOTERM_PKG_VERSION.tar.xz
NEOTERM_PKG_SHA256=a5042630304cf8e5d8cff9d565c6bd546f228b48c960153ed366a34e87cad1e5
NEOTERM_PKG_DEPENDS="glib"

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--with-extra-only
"
