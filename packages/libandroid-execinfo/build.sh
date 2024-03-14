NEOTERM_PKG_HOMEPAGE=https://man7.org/linux/man-pages/man3/backtrace.3.html
NEOTERM_PKG_DESCRIPTION="Shared library for the backtrace system function"
NEOTERM_PKG_LICENSE="BSD 2-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.1
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_SKIP_SRC_EXTRACT=true
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_PROVIDES="libexecinfo"
NEOTERM_PKG_CONFLICTS="libexecinfo"

# Files are taken from the Bionic libc repo. 
# exexinfo.h: https://android.googlesource.com/platform/bionic/+/refs/heads/master/libc/include/execinfo.h
# execinfo.c: https://android.googlesource.com/platform/bionic/+/refs/heads/master/libc/bionic/execinfo.cpp
neoterm_step_make() {
	$CC $CFLAGS -I$NEOTERM_PKG_BUILDER_DIR -c $NEOTERM_PKG_BUILDER_DIR/execinfo.c
	$CC $LDFLAGS -shared execinfo.o -o libandroid-execinfo.so \
		-Wl,-soname=libandroid-execinfo.so
	$AR rcu libandroid-execinfo.a execinfo.o
	cp -f $NEOTERM_PKG_BUILDER_DIR/LICENSE $NEOTERM_PKG_SRCDIR/
}

neoterm_step_make_install() {
	install -Dm600 $NEOTERM_PKG_BUILDER_DIR/execinfo.h $NEOTERM_PREFIX/include/execinfo.h
	install -Dm600 libandroid-execinfo.a $NEOTERM_PREFIX/lib/libandroid-execinfo.a
	install -Dm600 libandroid-execinfo.so $NEOTERM_PREFIX/lib/libandroid-execinfo.so
	ln -sfr $NEOTERM_PREFIX/lib/libandroid-execinfo.so $NEOTERM_PREFIX/lib/libexecinfo.so
}
