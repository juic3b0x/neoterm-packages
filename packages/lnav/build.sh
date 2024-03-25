NEOTERM_PKG_HOMEPAGE=https://lnav.org/
NEOTERM_PKG_DESCRIPTION="An advanced log file viewer for the small-scale"
NEOTERM_PKG_LICENSE="BSD 2-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.11.2
NEOTERM_PKG_SRCURL=https://github.com/tstack/lnav/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=03b72fd02faccdbf98fcdeba62306794b677b8bcf49d6023117808f88ed627dc
NEOTERM_PKG_DEPENDS="libandroid-execinfo, libandroid-glob, libarchive, libbz2, libc++, libcurl, libsqlite, ncurses, pcre2, readline, zlib"

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-system-paths
--disable-static
--with-pcre2=$NEOTERM_PREFIX
"

neoterm_step_post_get_source() {
	cp $NEOTERM_PKG_BUILDER_DIR/sys_time.c src/
}

neoterm_step_pre_configure() {
	autoreconf -fi

	LDFLAGS+=" -landroid-glob"
}
