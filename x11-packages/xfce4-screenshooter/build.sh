NEOTERM_PKG_HOMEPAGE=https://docs.xfce.org/apps/xfce4-screenshooter/start
NEOTERM_PKG_DESCRIPTION="The Xfce4-screenshooter is an application that can be used to take snapshots of your desktop screen."
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="Yisus7u7 <dev.yisus@hotmail.com>"
_MAJOR_VERSION=1.10
NEOTERM_PKG_VERSION=${_MAJOR_VERSION}.4
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://archive.xfce.org/src/apps/xfce4-screenshooter/${_MAJOR_VERSION}/xfce4-screenshooter-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=a2f199687e54e16a936d5636d660d42b6b9a5d548cdd0f04bd69213554806494
NEOTERM_PKG_DEPENDS="atk, exo, gdk-pixbuf, glib, gtk3, harfbuzz, libcairo, libice, libsm, libsoup3, libx11, libxext, libxfce4ui, libxfce4util, libxfixes, libxml2, pango, xfce4-panel, xfconf, zlib"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_prog_HELP2MAN=
"
