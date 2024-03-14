NEOTERM_PKG_HOMEPAGE=https://st.suckless.org/
NEOTERM_PKG_DESCRIPTION="A simple virtual terminal emulator for X"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="Tristan Ross <spaceboyross@yandex.com>"
NEOTERM_PKG_VERSION=0.9
NEOTERM_PKG_SRCURL="https://dl.suckless.org/st/st-$NEOTERM_PKG_VERSION.tar.gz"
NEOTERM_PKG_SHA256=f36359799734eae785becb374063f0be833cf22f88b4f169cd251b99324e08e7
# FIXME: config.h specified a Liberation Mono font which is not available in Termux.
# Needs a patch for ttf-dejavu font package or liberation font package should be added.
NEOTERM_PKG_DEPENDS="fontconfig, freetype, libx11, libxft"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="TERMINFO=$NEOTERM_PREFIX/share/terminfo"
NEOTERM_PKG_RM_AFTER_INSTALL="share/terminfo"

neoterm_step_pre_configure() {
	cp config.def.h config.h
}
