NEOTERM_PKG_HOMEPAGE=https://www.washington.edu/imap/ # Gone.
NEOTERM_PKG_DESCRIPTION="UW IMAP c-client library"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2007f
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://www.mirrorservice.org/sites/ftp.cac.washington.edu/imap/imap-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=53e15a2b5c1bc80161d42e9f69792a3fa18332b7b771910131004eb520004a28
NEOTERM_PKG_DEPENDS="openssl"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	CFLAGS+=" -fPIC $CPPFLAGS -DFNDELAY=O_NONBLOCK -DL_SET=SEEK_SET"
	LDFLAGS+=" -lssl -lcrypto"
}

neoterm_step_configure() {
	:
}

neoterm_step_make() {
	make -e slx

	mv c-client/{,lib}c-client.a
	$CC -Wl,--whole-archive c-client/libc-client.a -Wl,--no-whole-archive -shared -o c-client/libc-client.so -Wl,-soname=libc-client.so $LDFLAGS
}

neoterm_step_make_install() {
	install -Dm600 -t $NEOTERM_PREFIX/lib c-client/libc-client.{a,so}
	install -Dm600 -t $NEOTERM_PREFIX/include/c-client c-client/linkage.[ch] src/c-client/*.h src/osdep/unix/*.h
	cp -a c-client/osdep.h $NEOTERM_PREFIX/include/c-client/
}
