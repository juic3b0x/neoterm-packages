NEOTERM_PKG_HOMEPAGE=https://man7.org/linux/man-pages/man3/glob.3.html
NEOTERM_PKG_DESCRIPTION="Shared library for the glob(3) system function"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.6
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SKIP_SRC_EXTRACT=true
NEOTERM_PKG_BREAKS="libandroid-glob-dev"
NEOTERM_PKG_REPLACES="libandroid-glob-dev"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=false

neoterm_step_make() {
	$CC $CFLAGS $CPPFLAGS -I$NEOTERM_PKG_BUILDER_DIR -c $NEOTERM_PKG_BUILDER_DIR/glob.c
	$CC $LDFLAGS -shared glob.o -o libandroid-glob.so
	$AR rcu libandroid-glob.a glob.o
	cp -f $NEOTERM_PKG_BUILDER_DIR/LICENSE $NEOTERM_PKG_SRCDIR/
}

neoterm_step_make_install() {
	install -Dm600 $NEOTERM_PKG_BUILDER_DIR/glob.h $NEOTERM_PREFIX/include/glob.h
	install -Dm600 libandroid-glob.a $NEOTERM_PREFIX/lib/libandroid-glob.a
	install -Dm600 libandroid-glob.so $NEOTERM_PREFIX/lib/libandroid-glob.so
}
