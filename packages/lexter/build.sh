NEOTERM_PKG_HOMEPAGE=https://www.kyne.com.au/~mark/software/lexter.php
NEOTERM_PKG_DESCRIPTION="A real-time word puzzle for text terminals"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="Henrik Grimler @Grimler91"
NEOTERM_PKG_VERSION=1.0.3
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://www.kyne.com.au/~mark/software/download/lexter-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=b61a28fd5249b7d6c0df9be91c97c2acd00ccd9ad1e7b0c99808f6cdc96d5188
NEOTERM_PKG_DEPENDS="ncurses, gettext"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--datadir=$NEOTERM_PREFIX/share/lexter"
NEOTERM_PKG_GROUPS="games"

neoterm_step_pre_configure() {
	autoreconf -vfi
}
