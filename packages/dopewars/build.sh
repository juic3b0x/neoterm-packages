NEOTERM_PKG_HOMEPAGE=https://dopewars.sourceforge.io
NEOTERM_PKG_DESCRIPTION="Drug-dealing game set in streets of New York City"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.6.2
NEOTERM_PKG_SRCURL=https://prdownloads.sourceforge.net/dopewars/dopewars-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=623b9d1d4d576f8b1155150975308861c4ec23a78f9cc2b24913b022764eaae1
NEOTERM_PKG_DEPENDS="glib, libcurl, ncurses"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--without-sdl
"
NEOTERM_PKG_RM_AFTER_INSTALL="share/gnome"
NEOTERM_PKG_GROUPS="games"

neoterm_step_pre_configure() {
	autoreconf -vfi
}
