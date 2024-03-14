NEOTERM_PKG_HOMEPAGE=http://atterer.org/jigdo/
NEOTERM_PKG_DESCRIPTION="Distribute large images by sending and receiving the files that make them up"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.8.2"
NEOTERM_PKG_SRCURL=https://www.einval.com/~steve/software/jigdo/download/jigdo-$NEOTERM_PKG_VERSION.tar.xz
NEOTERM_PKG_SHA256=36f286d93fa6b6bf7885f4899c997894d21da3a62176592ac162d9c6a8644f9e
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libbz2, libc++, libdb, wget, zlib"
NEOTERM_PKG_BUILD_IN_SRC=true

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--mandir=$NEOTERM_PREFIX/share/man
--without-gui
"

neoterm_step_pre_configure() {
	# Should prevent random failures on installation step.
	export NEOTERM_MAKE_PROCESSES=1
}
