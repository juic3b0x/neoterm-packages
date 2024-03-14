NEOTERM_PKG_HOMEPAGE="https://kristaps.bsd.lv/lowdown"
NEOTERM_PKG_DESCRIPTION="Markdown utilities and library (fork of hoedown -> sundown -> libsoldout)"
NEOTERM_PKG_LICENSE="ISC"
NEOTERM_PKG_LICENSE_FILE="LICENSE.md"
NEOTERM_PKG_MAINTAINER="@flosnvjx"
NEOTERM_PKG_VERSION="1.1.0"
NEOTERM_PKG_SRCURL="https://kristaps.bsd.lv/lowdown/snapshots/lowdown-${NEOTERM_PKG_VERSION}.tar.gz"
NEOTERM_PKG_SHA256=f31e3950c4732b1e409174fa092eca40c55be77a448ee2818df987979d7b0879
#NEOTERM_PKG_BUILD_DEPENDS="libseccomp" ## it is merely a checkdepends for now and we dont run check during build
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_MAKE_INSTALL_TARGET="install install_libs" ## add "regress" target if one wanna run check
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_METHOD=repology

neoterm_step_configure() {
	## avoid hard-linking during make
	sed -Ee 's%^([\t ]*ln) -f (lowdown lowdown-diff)$%\1 -srf \2%' -i Makefile

	## not an autoconf script
	./configure \
		LDFLAGS="$LDFLAGS" \
		CPPFLAGS="$CPPFLAGS" \
		PREFIX="$NEOTERM_PREFIX" \
		MANDIR="$NEOTERM_PREFIX/share/man"
}
