NEOTERM_PKG_HOMEPAGE=https://nmon.sourceforge.net/
NEOTERM_PKG_DESCRIPTION="Curses based Performance Monitor for Linux with saving performance stats to a CSV file mode"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="16p"
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/nmon/lmon${NEOTERM_PKG_VERSION}.c
NEOTERM_PKG_SHA256=5dc6045f6725e3249a969918fae69663a1d669162087720babcdb90fce9e6b2a
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="ncurses"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_get_source() {
	neoterm_download $NEOTERM_PKG_SRCURL $NEOTERM_PKG_CACHEDIR/lmon.c $NEOTERM_PKG_SHA256
	mkdir -p $NEOTERM_PKG_SRCDIR
	cp $NEOTERM_PKG_CACHEDIR/lmon.c $NEOTERM_PKG_SRCDIR
}

neoterm_step_pre_configure() {
	case $NEOTERM_ARCH in
		aarch64 | arm ) CPPFLAGS+=" -DARM" ;;
		* ) CPPFLAGS+=" -DX86" ;;
	esac
}

neoterm_step_make() {
	$CC $CFLAGS $CPPFLAGS $NEOTERM_PKG_SRCDIR/lmon.c -o nmon $LDFLAGS -lncurses -lm
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin nmon
}
