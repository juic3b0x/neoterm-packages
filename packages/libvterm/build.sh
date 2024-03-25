NEOTERM_PKG_HOMEPAGE=https://www.leonerd.org.uk/code/libvterm/
NEOTERM_PKG_DESCRIPTION="Terminal emulator library"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1:0.3.2
NEOTERM_PKG_SRCURL=https://www.leonerd.org.uk/code/libvterm/libvterm-${NEOTERM_PKG_VERSION#*:}.tar.gz
NEOTERM_PKG_SHA256=91eb5088069f4e6edab69e14c4212f6da0192e65695956dc048016a0dab8bcf6
NEOTERM_PKG_BREAKS="libvterm-dev"
NEOTERM_PKG_REPLACES="libvterm-dev"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	make src/encoding/DECdrawing.inc src/encoding/uk.inc
}

neoterm_step_make_install() {
	cd $NEOTERM_PKG_SRCDIR/src
	$CC -std=c99 -shared -fPIC $LDFLAGS -o $NEOTERM_PREFIX/lib/libvterm.so \
		-Wl,-soname=libvterm.so *.c -I../include -I.
	cp ../include/*.h $NEOTERM_PREFIX/include/
}
