NEOTERM_PKG_HOMEPAGE=http://www.jemarch.net/poke.html
NEOTERM_PKG_DESCRIPTION="Interactive, extensible editor for binary data."
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="3.3"
NEOTERM_PKG_SRCURL=https://mirrors.kernel.org/gnu/poke/poke-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=0080459de85063c83b689ffcfba36872236803c12242d245a42ee793594f956e
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="gettext, libgc, ncurses, readline"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_header_glob_h=no
--disable-hserver
--disable-threads
--with-sysroot=$NEOTERM_BASE_DIR
"
