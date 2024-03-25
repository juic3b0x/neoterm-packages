NEOTERM_PKG_HOMEPAGE=https://www.openssl.org/
NEOTERM_PKG_DESCRIPTION="Library implementing the SSL and TLS protocols as well as general purpose cryptography functions"
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="LICENSE"
NEOTERM_PKG_MAINTAINER="@neoterm"
_VERSION=1.1.1w
NEOTERM_PKG_VERSION=1:${_VERSION}
NEOTERM_PKG_SRCURL=https://www.openssl.org/source/openssl-${_VERSION/\~/-}.tar.gz
NEOTERM_PKG_SHA256=cf3098950cb4d853ad95c0841f1f9c6d3dc102dccfcacd521d93925208b76ac8
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_DEPENDS="ca-certificates, zlib"
NEOTERM_PKG_CONFFILES="etc/tls/openssl.cnf"
NEOTERM_PKG_RM_AFTER_INSTALL="bin/c_rehash etc/"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_CONFLICTS="libcurl (<< 7.61.0-1)"
NEOTERM_PKG_BREAKS="openssl (<< 1.1.1m)"
NEOTERM_PKG_REPLACES="openssl (<< 1.1.1m)"

neoterm_step_pre_configure() {
	test -d $NEOTERM_PREFIX/include/openssl && mv $NEOTERM_PREFIX/include/openssl{,.tmp} || :
	LDFLAGS="-L$NEOTERM_PREFIX/lib/openssl-1.1 -Wl,-rpath=$NEOTERM_PREFIX/lib/openssl-1.1 $LDFLAGS"
}

neoterm_step_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $NEOTERM_PREFIX.
	if $NEOTERM_ON_DEVICE_BUILD; then
		neoterm_error_exit "Package '$NEOTERM_PKG_NAME' is not safe for on-device builds."
	fi

	CFLAGS+=" -DNO_SYSLOG"

	perl -p -i -e "s@NEOTERM_CFLAGS@$CFLAGS@g" Configure
	test $NEOTERM_ARCH = "arm" && NEOTERM_OPENSSL_PLATFORM="android-arm"
	test $NEOTERM_ARCH = "aarch64" && NEOTERM_OPENSSL_PLATFORM="android-arm64"
	test $NEOTERM_ARCH = "i686" && NEOTERM_OPENSSL_PLATFORM="android-x86"
	test $NEOTERM_ARCH = "x86_64" && NEOTERM_OPENSSL_PLATFORM="android-x86_64"

	install -m755 -d $NEOTERM_PREFIX/lib/openssl-1.1

	./Configure $NEOTERM_OPENSSL_PLATFORM \
		--prefix=$NEOTERM_PREFIX \
		--openssldir=$NEOTERM_PREFIX/etc/tls \
		--libdir=$NEOTERM_PREFIX/lib/openssl-1.1 \
		shared \
		zlib-dynamic \
		no-ssl \
		no-hw \
		no-srp \
		no-tests
}

neoterm_step_make() {
	make depend
	make -j $NEOTERM_MAKE_PROCESSES all
}

neoterm_step_make_install() {
	# "install_sw" instead of "install" to not install man pages:
	make -j 1 install_sw MANDIR=$NEOTERM_PREFIX/share/man MANSUFFIX=.ssl

	mkdir -p $NEOTERM_PREFIX/etc/tls/

	cp apps/openssl.cnf $NEOTERM_PREFIX/etc/tls/openssl.cnf

	install -m755 -d $NEOTERM_PREFIX/include/openssl-1.1
	mv $NEOTERM_PREFIX/include/openssl $NEOTERM_PREFIX/include/openssl-1.1/
	mv $NEOTERM_PREFIX/bin/openssl $NEOTERM_PREFIX/bin/openssl-1.1
}

neoterm_step_post_make_install() {
	test -d $NEOTERM_PREFIX/include/openssl.tmp && mv $NEOTERM_PREFIX/include/openssl{.tmp,} || :
}

neoterm_step_post_massage() {
	rm -rf include/openssl
}
