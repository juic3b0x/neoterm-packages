NEOTERM_PKG_HOMEPAGE=https://man7.org/linux/man-pages/man7/sem_overview.7.html
NEOTERM_PKG_DESCRIPTION="Shared library for the posix semaphore system function"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.1
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SKIP_SRC_EXTRACT=true
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=false

neoterm_step_make() {
	$CC $CFLAGS $CPPFLAGS -c $NEOTERM_PKG_BUILDER_DIR/semaphore.c
	$CC $LDFLAGS -shared semaphore.o -o libandroid-posix-semaphore.so
	$AR rcu libandroid-posix-semaphore.a semaphore.o
	cp -f $NEOTERM_PKG_BUILDER_DIR/LICENSE $NEOTERM_PKG_SRCDIR/
}

neoterm_step_make_install() {
	install -Dm600 libandroid-posix-semaphore.a $NEOTERM_PREFIX/lib/libandroid-posix-semaphore.a
	install -Dm600 libandroid-posix-semaphore.so $NEOTERM_PREFIX/lib/libandroid-posix-semaphore.so
}
