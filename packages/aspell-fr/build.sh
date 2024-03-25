NEOTERM_PKG_HOMEPAGE=http://aspell.net/
NEOTERM_PKG_DESCRIPTION="French dictionary for aspell"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2:0.50-3
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://ftp.gnu.org/gnu/aspell/dict/fr/aspell-fr-${NEOTERM_PKG_VERSION:2}.tar.bz2
NEOTERM_PKG_SHA256=f9421047519d2af9a7a466e4336f6e6ea55206b356cd33c8bd18cb626bf2ce91
NEOTERM_PKG_DEPENDS="aspell"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true

neoterm_step_configure() {
	cat > $NEOTERM_PKG_SRCDIR/Makefile <<- EOF
	ASPELL = $(command -v aspell)
	ASPELL_FLAGS = 
	WORD_LIST_COMPRESS = $(command -v word-list-compress)
	DESTDIR =
	dictdir = $NEOTERM_PREFIX/lib/aspell-0.60
	datadir = $NEOTERM_PREFIX/lib/aspell-0.60
	EOF
	cat $NEOTERM_PKG_SRCDIR/Makefile.pre >> $NEOTERM_PKG_SRCDIR/Makefile
}
