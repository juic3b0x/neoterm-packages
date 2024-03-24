TERMUX_PKG_HOMEPAGE=https://dev.yorhel.nl/ncdu
TERMUX_PKG_DESCRIPTION="Disk usage analyzer"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@neoterm"
TERMUX_PKG_VERSION=1.19
TERMUX_PKG_SRCURL=https://dev.yorhel.nl/download/ncdu-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=30363019180cde0752c7fb006c12e154920412f4e1b5dc3090654698496bb17d
TERMUX_PKG_DEPENDS="libandroid-support, ncurses"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--with-shell=$TERMUX_PREFIX/bin/bash"
TERMUX_PKG_AUTO_UPDATE=false
