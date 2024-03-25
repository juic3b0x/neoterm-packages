NEOTERM_PKG_HOMEPAGE=https://www.greenwoodsoftware.com/less/
NEOTERM_PKG_DESCRIPTION="Terminal pager program used to view the contents of a text file one screen at a time"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=633
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://www.greenwoodsoftware.com/less/less-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=2f201d64b828b88af36dfe6cfdba3e0819ece2e446ebe6224813209aaefed04f
NEOTERM_PKG_DEPENDS="ncurses, pcre2"
NEOTERM_PKG_ESSENTIAL=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--with-regex=pcre2"
