NEOTERM_PKG_HOMEPAGE=http://aspell.net/
NEOTERM_PKG_DESCRIPTION="English dictionary for aspell"
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="Copyright"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1:2020.12.07
NEOTERM_PKG_SRCURL=https://ftp.gnu.org/gnu/aspell/dict/en/aspell6-en-${NEOTERM_PKG_VERSION:2}-0.tar.bz2
NEOTERM_PKG_SHA256=4c8f734a28a088b88bb6481fcf972d0b2c3dc8da944f7673283ce487eac49fb3
NEOTERM_PKG_DEPENDS="aspell"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true

neoterm_step_configure() {
	cat > $NEOTERM_PKG_SRCDIR/Makefile <<- EOF
	ASPELL = `command -v aspell`
	ASPELL_FLAGS = 
	PREZIP = `command -v prezip`
	DESTDIR =
	dictdir = $NEOTERM_PREFIX/lib/aspell-0.60
	datadir = $NEOTERM_PREFIX/lib/aspell-0.60
	EOF
	cat $NEOTERM_PKG_SRCDIR/Makefile.pre >> $NEOTERM_PKG_SRCDIR/Makefile
}
