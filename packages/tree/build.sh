NEOTERM_PKG_HOMEPAGE=http://mama.indstate.edu/users/ice/tree/
NEOTERM_PKG_DESCRIPTION="Recursive directory lister producing a depth indented listing of files"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.1.1"
NEOTERM_PKG_SRCURL="https://gitlab.com/OldManProgrammer/unix-tree/-/archive/${NEOTERM_PKG_VERSION}/unix-tree-${NEOTERM_PKG_VERSION}.tar.gz"
NEOTERM_PKG_SHA256=bcd2a0327ad40592a9c43e09a4d2ef834e6f17aa9a59012a5fb1007950b5eced
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_DEPENDS="libandroid-support"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	make \
		CC="$CC" \
		CFLAGS="$CFLAGS $CPPFLAGS -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64" \
		LDFLAGS="$LDFLAGS"
}

neoterm_step_make_install() {
	make install \
		PREFIX="$NEOTERM_PREFIX" \
		MANDIR="$NEOTERM_PREFIX/share/man/man1"
}
