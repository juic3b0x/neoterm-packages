NEOTERM_PKG_HOMEPAGE=http://aspell.net/
NEOTERM_PKG_DESCRIPTION="German dictionary for aspell"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1:20161207.7.0"
NEOTERM_PKG_SRCURL=https://ftp.gnu.org/gnu/aspell/dict/de/aspell6-de-$(sed 's/\./-/g' <<< ${NEOTERM_PKG_VERSION:2}).tar.bz2
NEOTERM_PKG_SHA256=c2125d1fafb1d4effbe6c88d4e9127db59da9ed92639c7cbaeae1b7337655571
NEOTERM_PKG_DEPENDS="aspell"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true

neoterm_step_configure() {
	cd ${NEOTERM_PKG_SRCDIR}
	sed -i 's#^dictdir=.*#dictdir='${NEOTERM_PREFIX}'/lib/aspell-0.60#' configure
	sed -i 's#^datadir=.*#datadir='${NEOTERM_PREFIX}'/lib/aspell-0.60#' configure
	./configure
}

neoterm_step_make() {
	make
}

neoterm_step_make_install() {
    make install
	echo "add de_CH.multi" > "${NEOTERM_PREFIX}/lib/aspell-0.60/swiss.alias"
}
