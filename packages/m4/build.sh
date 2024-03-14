NEOTERM_PKG_HOMEPAGE=https://www.gnu.org/software/m4/m4.html
NEOTERM_PKG_DESCRIPTION="Traditional Unix macro processor"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.4.19
NEOTERM_PKG_REVISION=4
NEOTERM_PKG_SRCURL=https://mirrors.kernel.org/gnu/m4/m4-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=63aede5c6d33b6d9b13511cd0be2cac046f2e70fd0a07aa9573a04a82783af96
NEOTERM_PKG_BUILD_DEPENDS="libandroid-spawn"
NEOTERM_PKG_GROUPS="base-devel"
NEOTERM_PKG_EXTRA_MAKE_ARGS="
HELP2MAN=:
"
# Avoid automagic dependency on libiconv
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" am_cv_func_iconv=no"

neoterm_step_pre_configure() {
	CPPFLAGS+=" -D__USE_FORTIFY_LEVEL=0"
}
