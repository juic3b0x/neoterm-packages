NEOTERM_PKG_HOMEPAGE=https://cscope.sourceforge.net/
NEOTERM_PKG_DESCRIPTION="A developers tool for browsing program code"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=15.9
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://fossies.org/linux/misc/cscope-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=c5505ae075a871a9cd8d9801859b0ff1c09782075df281c72c23e72115d9f159
NEOTERM_PKG_DEPENDS="ncurses"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
hw_cv_func_snprintf_c99=yes
hw_cv_func_vsnprintf_c99=yes
--with-ncurses=$NEOTERM_PREFIX
"

neoterm_step_pre_configure() {
	export LEXLIB=""
}
