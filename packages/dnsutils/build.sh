NEOTERM_PKG_HOMEPAGE=https://www.isc.org/downloads/bind/
NEOTERM_PKG_DESCRIPTION="Clients provided with BIND"
NEOTERM_PKG_LICENSE="MPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=9.16.41
NEOTERM_PKG_SRCURL="https://ftp.isc.org/isc/bind9/${NEOTERM_PKG_VERSION}/bind-${NEOTERM_PKG_VERSION}.tar.xz"
NEOTERM_PKG_SHA256=71904366aa1e04e2075c79a8906b92af936e3bfa4d7e8df5fd964fcf9e94f45c
NEOTERM_PKG_DEPENDS="openssl, readline, resolv-conf, zlib, libuv"
NEOTERM_PKG_BREAKS="dnsutils-dev"
NEOTERM_PKG_REPLACES="dnsutils-dev"
NEOTERM_PKG_BUILD_IN_SRC=true

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-linux-caps
--without-python
--with-ecdsa=no
--with-gost=no
--with-gssapi=no
--with-libjson=no
--with-libtool
--with-libxml2=no
--with-openssl=$NEOTERM_PREFIX
--with-randomdev=/dev/random
--with-readline=-lreadline
--with-eddsa=no
ax_cv_have_func_attribute_constructor=yes
ax_cv_have_func_attribute_destructor=yes
"

neoterm_step_pre_configure() {
	export BUILD_AR=ar
	export BUILD_CC=gcc
	export BUILD_CFLAGS=
	export BUILD_CPPFLAGS=
	export BUILD_LDFLAGS=
	export BUILD_RANLIB=

	_RESOLV_CONF=$NEOTERM_PREFIX/etc/resolv.conf
	CFLAGS+=" $CPPFLAGS -DRESOLV_CONF=\\\"$_RESOLV_CONF\\\""
}

neoterm_step_make() {
	make -C lib/isc
	make -C lib/dns
	make -C lib/ns
	make -C lib/isccc
	make -C lib/isccfg
	make -C lib/bind9
	make -C lib/irs
	make -C bin/dig
	make -C bin/delv
	make -C bin/nsupdate
}

neoterm_step_make_install() {
	make -C lib/isc install
	make -C lib/dns install
	make -C lib/ns install
	make -C lib/isccc install
	make -C lib/isccfg install
	make -C lib/bind9 install
	make -C lib/irs install
	make -C bin/dig install
	make -C bin/delv install
	make -C bin/nsupdate install
}
