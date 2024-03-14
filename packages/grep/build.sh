NEOTERM_PKG_HOMEPAGE=https://www.gnu.org/software/grep/
NEOTERM_PKG_DESCRIPTION="Command which searches one or more input files for lines containing a match to a specified pattern"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.11
NEOTERM_PKG_SRCURL=https://mirrors.kernel.org/gnu/grep/grep-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=1db2aedde89d0dea42b16d9528f894c8d15dae4e190b59aecc78f5a951276eab
NEOTERM_PKG_DEPENDS="libandroid-support, pcre2"
NEOTERM_PKG_ESSENTIAL=true
NEOTERM_PKG_GROUPS="base-devel"

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_func_nl_langinfo=no
ac_cv_header_langinfo_h=no
am_cv_langinfo_codeset=no
gl_cv_func_setlocale_works=yes
"
# Avoid automagic dependency on libiconv
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" am_cv_func_iconv=no"
