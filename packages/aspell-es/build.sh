NEOTERM_PKG_HOMEPAGE=http://aspell.net/
NEOTERM_PKG_DESCRIPTION="Spanish dictionary for aspell"
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="Copyright"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2:1.11-2
NEOTERM_PKG_SRCURL=https://ftp.gnu.org/gnu/aspell/dict/es/aspell6-es-${NEOTERM_PKG_VERSION:2}.tar.bz2
NEOTERM_PKG_SHA256=ad367fa1e7069c72eb7ae37e4d39c30a44d32a6aa73cedccbd0d06a69018afcc
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
