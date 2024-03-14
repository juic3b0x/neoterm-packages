NEOTERM_PKG_HOMEPAGE=https://boxes.thomasjensen.com/
NEOTERM_PKG_DESCRIPTION="A command line filter program which draws ASCII art boxes around your input text"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.3.0"
NEOTERM_PKG_SRCURL=https://github.com/ascii-boxes/boxes/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=e226b4ff91e1260fc80e8312b39cde5a783b96e9f248530eae941b7f1bf6342a
NEOTERM_PKG_DEPENDS="libunistring, ncurses, pcre2"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_CONFFILES="
share/boxes/boxes-config
"

neoterm_step_make() {
	make -j $NEOTERM_MAKE_PROCESSES \
		CC="$CC" \
		CFLAGS_ADDTL="$CFLAGS $CPPFLAGS" \
		LDFLAGS_ADDTL="$LDFLAGS"
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin out/boxes
	install -Dm600 -t $NEOTERM_PREFIX/share/man/man1 doc/boxes.1
	install -Dm600 -t $NEOTERM_PREFIX/share/boxes boxes-config
}

# Do not use /archive/ but /archive/refs/tags/ as SRCURL
# https://github.com/ascii-boxes/boxes/archive/v2.2.1.tar.gz
# the given path has multiple possibilities: #<Git::Ref:0x00007f3805df9d98>, #<Git::Ref:0x00007f3805df94d8>
