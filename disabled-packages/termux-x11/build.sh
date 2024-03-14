NEOTERM_PKG_HOMEPAGE=https://github.com/neoterm/x11-packages
NEOTERM_PKG_DESCRIPTION="Utility to start X11 Termux add-on"
NEOTERM_PKG_LICENSE="GPL-3.0" # same as Termux:X11 add-on app
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.0
NEOTERM_PKG_REVISION=4
NEOTERM_PKG_SKIP_SRC_EXTRACT=true
NEOTERM_PKG_DEPENDS="libwayland"

neoterm_step_make_install() {
	$CC $CFLAGS $CPPFLAGS -DNEOTERM_PREFIX=\"$NEOTERM_PREFIX\" \
		$NEOTERM_PKG_BUILDER_DIR/neoterm-x11.c -o $NEOTERM_PREFIX/bin/neoterm-x11 \
		$LDFLAGS -lwayland-client
}
