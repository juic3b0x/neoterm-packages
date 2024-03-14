NEOTERM_PKG_HOMEPAGE=https://www.gnu.org/software/sed/
NEOTERM_PKG_DESCRIPTION="GNU stream editor for filtering/transforming text"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=4.9
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://mirrors.kernel.org/gnu/sed/sed-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=6e226b732e1cd739464ad6862bd1a1aba42d7982922da7a53519631d24975181
NEOTERM_PKG_ESSENTIAL=true
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_GROUPS="base-devel"

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_func_nl_langinfo=no
ac_cv_header_langinfo_h=no
am_cv_langinfo_codeset=no
gl_cv_func_setlocale_works=yes
"

neoterm_step_pre_configure() {
	CFLAGS+=" -D__USE_FORTIFY_LEVEL=2"
}

neoterm_step_post_configure() {
	touch -d "next hour" $NEOTERM_PKG_SRCDIR/doc/sed.1
}
