NEOTERM_PKG_HOMEPAGE=https://android.googlesource.com/platform/bionic/+/refs/heads/master/libc/bionic/sys_sem.cpp
NEOTERM_PKG_DESCRIPTION="A shared library providing System V semaphores"
NEOTERM_PKG_LICENSE="BSD 2-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.1
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_SKIP_SRC_EXTRACT=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_post_get_source() {
	local f
	for f in LICENSE sys_sem.{c,h}; do
		cp $NEOTERM_PKG_BUILDER_DIR/${f} ./
	done
}

neoterm_step_pre_configure() {
	CPPFLAGS+=" -D__USE_GNU"
	CFLAGS+=" -fPIC"
}

neoterm_step_make() {
	$CC $CFLAGS $CPPFLAGS sys_sem.c -c
	$CC $CFLAGS sys_sem.o -shared $LDFLAGS -o libandroid-sysv-semaphore.so
	$AR cru libandroid-sysv-semaphore.a sys_sem.o
}

neoterm_step_make_install() {
	install -Dm600 -t $NEOTERM_PREFIX/lib libandroid-sysv-semaphore.{a,so}
	install -Dm600 -T sys_sem.h $NEOTERM_PREFIX/include/sys/sem.h
}
