NEOTERM_PKG_HOMEPAGE=http://www.mbayer.de/html2text/
NEOTERM_PKG_DESCRIPTION="Utility that converts HTML documents into plain text"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1:2.2.3"
NEOTERM_PKG_SRCURL=https://github.com/grobian/html2text/archive/v${NEOTERM_PKG_VERSION:2}.tar.gz
NEOTERM_PKG_SHA256=29e4b04e7cc7b9b6acb7db76edf4739d3a72a672f37452267e707d40249520ee
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libc++, libiconv"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	CXX="$CXX $CXXFLAGS $CPPFLAGS $LDFLAGS"
	mkdir -p $NEOTERM_PREFIX/share/man/man1
	aclocal
	autoconf
	automake --force-missing --add-missing
}
