NEOTERM_PKG_HOMEPAGE=https://vifm.info/
NEOTERM_PKG_DESCRIPTION="File manager with vi like keybindings"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.13
NEOTERM_PKG_SRCURL=https://github.com/vifm/vifm/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=8379397b2824cc74a91f5cfa00b5496f5d08cdcec18e3d13b64c480151225ca8
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="ncurses, file"

neoterm_step_pre_configure() {
	autoreconf -if
}
