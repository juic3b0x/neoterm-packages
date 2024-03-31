NEOTERM_PKG_HOMEPAGE=https://dwm.suckless.org/
NEOTERM_PKG_DESCRIPTION="A dynamic window manager for X"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="Tristan Ross <spaceboyross@yandex.com>"
NEOTERM_PKG_VERSION=6.4
NEOTERM_PKG_SRCURL="https://dl.suckless.org/dwm/dwm-$NEOTERM_PKG_VERSION.tar.gz"
NEOTERM_PKG_SHA256=fa9c0d69a584485076cfc18809fd705e5c2080dafb13d5e729a3646ca7703a6e
NEOTERM_PKG_DEPENDS="dmenu, fontconfig, libx11, libxft, libxinerama, st"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	cp config.def.h config.h
}
