NEOTERM_PKG_HOMEPAGE=https://www.xfce.org/
NEOTERM_PKG_DESCRIPTION="Application library for XFCE"
NEOTERM_PKG_LICENSE="GPL-2.0, LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
_MAJOR_VERSION=4.18
NEOTERM_PKG_VERSION=${_MAJOR_VERSION}.0
NEOTERM_PKG_SRCURL=https://archive.xfce.org/src/xfce/exo/${_MAJOR_VERSION}/exo-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=4f2c61d045a888cdb64297fd0ae20cc23da9b97ffb82562ed12806ed21da7d55
NEOTERM_PKG_DEPENDS="atk, gdk-pixbuf, glib, gtk3, harfbuzz, libcairo, libice, libsm, libx11, libxfce4ui, libxfce4util, pango"
NEOTERM_PKG_RECOMMENDS="hicolor-icon-theme"
NEOTERM_PKG_CONFLICTS="libexo"
NEOTERM_PKG_REPLACES="libexo"
NEOTERM_PKG_PROVIDES="libexo"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--enable-gtk-doc-html=no"
