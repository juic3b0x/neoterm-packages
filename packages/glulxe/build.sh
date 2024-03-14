NEOTERM_PKG_HOMEPAGE=https://www.eblong.com/zarf/glulx/
NEOTERM_PKG_DESCRIPTION="Interpreter for the Glulx portable VM for interactive fiction (IF) games"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=(0.5.4
                    1.0.4)
NEOTERM_PKG_REVISION=5
NEOTERM_PKG_SRCURL=(https://www.eblong.com/zarf/glulx/glulxe-${NEOTERM_PKG_VERSION[0]//.}.tar.gz
                   https://www.eblong.com/zarf/glk/glktermw-${NEOTERM_PKG_VERSION[1]//.}.tar.gz)
NEOTERM_PKG_SHA256=(1fc26f8aa31c880dbc7c396ede196c5d2cdff9bdefc6b192f320a96c5ef3376e
                   5968630b45e2fd53de48424559e3579db0537c460f4dc2631f258e1c116eb4ea)
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_DEPENDS="ncurses"
NEOTERM_PKG_GROUPS="games"

neoterm_step_post_configure () {
	CC="$CC $CFLAGS $CPPFLAGS $LDFLAGS" PREFIX=$NEOTERM_PREFIX make -C glkterm
}

neoterm_step_make_install () {
	install glulxe $NEOTERM_PREFIX/bin
}
