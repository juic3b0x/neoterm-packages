NEOTERM_PKG_HOMEPAGE=https://man7.org/linux/man-pages/man3/wordexp.3.html
NEOTERM_PKG_DESCRIPTION="Shared library for the wordexp(3) system function"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.1
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_SKIP_SRC_EXTRACT=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	$CC $CFLAGS $CPPFLAGS -I$NEOTERM_PKG_BUILDER_DIR -c $NEOTERM_PKG_BUILDER_DIR/wordexp.c
	$CC $LDFLAGS -shared wordexp.o -o libandroid-wordexp.so
	$AR rcu libandroid-wordexp.a wordexp.o
}

neoterm_step_make_install() {
	install -Dm600 $NEOTERM_PKG_BUILDER_DIR/wordexp.h $NEOTERM_PREFIX/include/wordexp.h
	install -Dm600 libandroid-wordexp.a $NEOTERM_PREFIX/lib/libandroid-wordexp.a
	install -Dm600 libandroid-wordexp.so $NEOTERM_PREFIX/lib/libandroid-wordexp.so
}
