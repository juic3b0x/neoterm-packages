NEOTERM_PKG_HOMEPAGE=https://www.gnu.org/software/gnuit/
NEOTERM_PKG_DESCRIPTION="gnuit - GNU Interactive Tools"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=4.9.5
NEOTERM_PKG_SRCURL=https://mirrors.kernel.org/gnu/gnuit/gnuit-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=6b6e96db13bafa5ad35c735b2277699d4244088c709a3e134fb1a3e8c8a8557c
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--disable-transition"
NEOTERM_PKG_DEPENDS="libandroid-support, ncurses"

neoterm_step_post_massage() {
	cd $NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX/share/gnuit
	ln -s gnuitrc.xterm-color gnuitrc.xterm-256color
	ln -s gnuitrc.screen gnuitrc.screen-color
	ln -s gnuitrc.screen gnuitrc.screen-256color
}
