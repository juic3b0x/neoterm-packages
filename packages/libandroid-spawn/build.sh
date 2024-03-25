NEOTERM_PKG_HOMEPAGE=https://man7.org/linux/man-pages/man3/posix_spawn.3.html
NEOTERM_PKG_DESCRIPTION="Shared library for the posix_spawn system function"
NEOTERM_PKG_LICENSE="BSD 2-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.3
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_SKIP_SRC_EXTRACT=true
NEOTERM_PKG_DEPENDS="libc++"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	$CXX $CFLAGS $CPPFLAGS -I$NEOTERM_PKG_BUILDER_DIR -c $NEOTERM_PKG_BUILDER_DIR/posix_spawn.cpp
	$CXX $LDFLAGS -shared posix_spawn.o -o libandroid-spawn.so
	$AR rcu libandroid-spawn.a posix_spawn.o
	cp -f $NEOTERM_PKG_BUILDER_DIR/LICENSE $NEOTERM_PKG_SRCDIR/
}

neoterm_step_make_install() {
	install -Dm600 $NEOTERM_PKG_BUILDER_DIR/posix_spawn.h $NEOTERM_PREFIX/include/spawn.h
	install -Dm600 libandroid-spawn.a $NEOTERM_PREFIX/lib/libandroid-spawn.a
	install -Dm600 libandroid-spawn.so $NEOTERM_PREFIX/lib/libandroid-spawn.so
}
