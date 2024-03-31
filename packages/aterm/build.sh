NEOTERM_PKG_HOMEPAGE=https://sourceforge.net/projects/aterm/
NEOTERM_PKG_DESCRIPTION="An xterm replacement with transparency support"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.0.1
NEOTERM_PKG_REVISION=33
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/aterm/aterm-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=a161c3b2d9c7149130a41963899993af21eae92e8e362f4b5b3c7c4cb16760ce
NEOTERM_PKG_DEPENDS="libice, libsm, libx11, libxext, xorg-fonts-75dpi | xorg-fonts-100dpi"
NEOTERM_PKG_CONFLICTS="xterm"
NEOTERM_PKG_REPLACES="xterm"
NEOTERM_PKG_PROVIDES="xterm"
NEOTERM_PKG_BUILD_DEPENDS="libxt"
NEOTERM_PKG_BUILD_IN_SRC=true

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--enable-transparency=yes
--enable-background-image
--enable-fading
--enable-menubar
--enable-graphics
"

neoterm_step_post_make_install() {
	cat <<- EOF > $NEOTERM_PREFIX/bin/xterm
	#!${NEOTERM_PREFIX}/bin/sh
	exec ${NEOTERM_PREFIX}/bin/aterm +tr "\${@}"
	EOF
	chmod 700 $NEOTERM_PREFIX/bin/xterm
}
