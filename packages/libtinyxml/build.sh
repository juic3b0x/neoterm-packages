NEOTERM_PKG_HOMEPAGE="https://sourceforge.net/projects/tinyxml"
NEOTERM_PKG_DESCRIPTION="A simple, small, C++ XML parser"
NEOTERM_PKG_LICENSE="ZLIB"
NEOTERM_PKG_LICENSE_FILE="readme.txt"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.6.2"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL="http://downloads.sourceforge.net/tinyxml/tinyxml_${NEOTERM_PKG_VERSION//./_}.tar.gz"
NEOTERM_PKG_SHA256=15bdfdcec58a7da30adc87ac2b078e4417dbe5392f3afb719f9ba6d062645593
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_DEPENDS="libc++"

neoterm_step_make_install() {
	install -m 0755 libtinyxml.so \
		"$NEOTERM_PREFIX/lib/"
	install -m 0644 tinyxml.h tinystr.h \
		"$NEOTERM_PREFIX/include/"
}
