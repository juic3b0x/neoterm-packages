NEOTERM_PKG_HOMEPAGE=https://bitbucket.org/mpyne/game-music-emu/wiki/Home
NEOTERM_PKG_DESCRIPTION="A collection of video game music file emulators"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.6.3
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://bitbucket.org/mpyne/game-music-emu/downloads/game-music-emu-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=aba34e53ef0ec6a34b58b84e28bf8cfbccee6585cebca25333604c35db3e051d
NEOTERM_PKG_DEPENDS="libc++, zlib"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DGME_YM2612_EMU=Nuked
-DENABLE_UBSAN=OFF
"
