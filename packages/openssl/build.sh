NEOTERM_PKG_HOMEPAGE=https://www.openssl.org/
NEOTERM_PKG_DESCRIPTION="Library implementing the SSL and TLS protocols as well as general purpose cryptography functions"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1:3.2.1
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://www.openssl.org/source/openssl-${NEOTERM_PKG_VERSION:2}.tar.gz
NEOTERM_PKG_SHA256=83c7329fe52c850677d75e5d0b0ca245309b97e8ecbcfdc1dfdc4ab9fac35b39
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_DEPENDS="ca-certificates, zlib"
NEOTERM_PKG_CONFFILES="etc/tls/openssl.cnf"
NEOTERM_PKG_RM_AFTER_INSTALL="bin/c_rehash etc/ssl/misc"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_CONFLICTS="libcurl (<< 7.61.0-1)"
NEOTERM_PKG_BREAKS="openssl-tool (<< 1.1.1b-1), openssl-dev"
NEOTERM_PKG_REPLACES="openssl-tool (<< 1.1.1b-1), openssl-dev"

neoterm_step_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $NEOTERM_PREFIX.
	if $NEOTERM_ON_DEVICE_BUILD; then
		neoterm_error_exit "Package '$NEOTERM_PKG_NAME' is not safe for on-device builds."
	fi

	CFLAGS+=" -DNO_SYSLOG"

	perl -p -i -e "s@NEOTERM_CFLAGS@$CFLAGS@g" Configure
	rm -Rf $NEOTERM_PREFIX/lib/libcrypto.* $NEOTERM_PREFIX/lib/libssl.*
	test $NEOTERM_ARCH = "arm" && NEOTERM_OPENSSL_PLATFORM="android-arm"
	test $NEOTERM_ARCH = "aarch64" && NEOTERM_OPENSSL_PLATFORM="android-arm64"
	test $NEOTERM_ARCH = "i686" && NEOTERM_OPENSSL_PLATFORM="android-x86"
	test $NEOTERM_ARCH = "x86_64" && NEOTERM_OPENSSL_PLATFORM="android-x86_64"
	./Configure $NEOTERM_OPENSSL_PLATFORM \
		--prefix=$NEOTERM_PREFIX \
		--openssldir=$NEOTERM_PREFIX/etc/tls \
		shared \
		zlib-dynamic \
		no-ssl \
		no-hw \
		no-srp \
		no-tests \
		enable-tls1_3
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

	sed "s|@NEOTERM_PREFIX@|$NEOTERM_PREFIX|g" \
		$NEOTERM_PKG_BUILDER_DIR/add-trusted-certificate \
		> $NEOTERM_PREFIX/bin/add-trusted-certificate
	chmod 700 $NEOTERM_PREFIX/bin/add-trusted-certificate
}
