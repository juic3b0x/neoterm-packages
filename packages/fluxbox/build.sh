NEOTERM_PKG_HOMEPAGE=http://www.fluxbox.org
NEOTERM_PKG_DESCRIPTION="A lightweight and highly-configurable window manager"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.3.7
NEOTERM_PKG_REVISION=35
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/fluxbox/fluxbox-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=fc8c75fe94c54ed5a5dd3fd4a752109f8949d6df67a48e5b11a261403c382ec0
NEOTERM_PKG_DEPENDS="fontconfig, fribidi, imlib2, libc++, libiconv, libx11, libxext, libxft, libxinerama, libxpm, libxrandr, libxrender, xorg-xmessage"
NEOTERM_PKG_RECOMMENDS="aterm, feh"
NEOTERM_PKG_BUILD_IN_SRC=true

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--enable-imlib2
--enable-xft
--enable-xinerama
"

neoterm_step_pre_configure() {
	export CXXFLAGS="${CXXFLAGS} -Wno-c++11-narrowing"
}
