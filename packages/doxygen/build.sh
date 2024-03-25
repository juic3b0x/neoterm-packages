NEOTERM_PKG_HOMEPAGE=http://www.doxygen.org
NEOTERM_PKG_DESCRIPTION="A documentation system for C++, C, Java, IDL and PHP"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.10.0"
NEOTERM_PKG_SRCURL=https://github.com/doxygen/doxygen/archive/Release_${NEOTERM_PKG_VERSION//./_}.tar.gz
NEOTERM_PKG_SHA256=795692a53136ca9bb9a6cd72656968af7858a78be7d6d011e12ab1dce6b9533c
NEOTERM_PKG_DEPENDS="libc++, libiconv"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DBISON_EXECUTABLE=$(command -v bison)
-DCMAKE_BUILD_TYPE=Release
-DFLEX_EXECUTABLE=$(command -v flex)
-DPYTHON_EXECUTABLE=$(command -v python3)
-Dbuild_parse=yes
-Dbuild_xmlparser=yes
"
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+_\d+_\d+"
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"

neoterm_step_post_make_install() {
	mkdir -p "$NEOTERM_PREFIX"/share/man/man1
	cp "$NEOTERM_PKG_SRCDIR"/doc/doxygen.1 "$NEOTERM_PREFIX"/share/man/man1
}
