NEOTERM_PKG_HOMEPAGE=http://www.leonerd.org.uk/code/libtermkey/
NEOTERM_PKG_DESCRIPTION="Library for processing of keyboard entry for terminal-based programs"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.22
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=http://www.leonerd.org.uk/code/libtermkey/libtermkey-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=6945bd3c4aaa83da83d80a045c5563da4edd7d0374c62c0d35aec09eb3014600
NEOTERM_PKG_DEPENDS="libunibilium"
NEOTERM_PKG_BREAKS="libtermkey-dev"
NEOTERM_PKG_REPLACES="libtermkey-dev"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	CFLAGS+=" -std=c99 -DHAVE_UNIBILIUM=1"
}

neoterm_step_make() {
	$CC $CFLAGS $CPPFLAGS -c -fPIC termkey.c -o termkey.o
	$CC $CFLAGS $CPPFLAGS -c -fPIC driver-csi.c -o driver-csi.o
	$CC $CFLAGS $CPPFLAGS -c -fPIC driver-ti.c -o driver-ti.o

	$CC -shared -fPIC $LDFLAGS -o libtermkey.so \
		termkey.o driver-csi.o driver-ti.o -lunibilium
}

neoterm_step_make_install() {
	install -Dm600 -t $NEOTERM_PREFIX/lib libtermkey.so
	chmod u+w termkey.h
	install -Dm600 termkey.h $NEOTERM_PREFIX/include/
	LIBDIR=$NEOTERM_PREFIX/lib INCDIR=$NEOTERM_PREFIX/include VERSION=$NEOTERM_PKG_VERSION sh termkey.pc.sh > \
	        $PKG_CONFIG_LIBDIR/termkey.pc
}
