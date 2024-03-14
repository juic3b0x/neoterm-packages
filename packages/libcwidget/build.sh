NEOTERM_PKG_HOMEPAGE=https://salsa.debian.org/cwidget-team/
NEOTERM_PKG_DESCRIPTION="high-level terminal interface library for C++"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.5.18
NEOTERM_PKG_SRCURL=http://deb.debian.org/debian/pool/main/c/cwidget/cwidget_$NEOTERM_PKG_VERSION.orig.tar.xz
NEOTERM_PKG_SHA256=a2fb48ff86e41fe15072e6d87b9467ff3af57329586f4548d9f25cf50491c9fc
NEOTERM_PKG_DEPENDS="ncurses, libiconv, libsigc++-2.0"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--disable-werror"

neoterm_step_pre_configure() {
	CXXFLAGS+=" -DNCURSES_WIDECHAR=1"
	LDFLAGS+=" -liconv"

	if [ $NEOTERM_ARCH = aarch64 ] || [ $NEOTERM_ARCH = arm ]; then
		LDFLAGS+=" $($CC -print-libgcc-file-name)"
	fi
}
