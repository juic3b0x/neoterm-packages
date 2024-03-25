NEOTERM_PKG_HOMEPAGE=https://www.gnutls.org/
NEOTERM_PKG_DESCRIPTION="Secure communications library implementing the SSL, TLS and DTLS protocols and technologies around them"
NEOTERM_PKG_LICENSE="LGPL-2.1, GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="3.8.3"
NEOTERM_PKG_SRCURL=https://www.gnupg.org/ftp/gcrypt/gnutls/v${NEOTERM_PKG_VERSION%.*}/gnutls-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=f74fc5954b27d4ec6dfbb11dea987888b5b124289a3703afcada0ee520f4173e
NEOTERM_PKG_DEPENDS="libc++, libgmp, libnettle, ca-certificates, libidn2, libunbound, libunistring"
NEOTERM_PKG_BREAKS="libgnutls-dev"
NEOTERM_PKG_REPLACES="libgnutls-dev"
NEOTERM_PKG_BUILD_IN_SRC=true

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--enable-cxx
--disable-hardware-acceleration
--disable-openssl-compatibility
--with-default-trust-store-file=$NEOTERM_PREFIX/etc/tls/cert.pem
--with-system-priority-file=${NEOTERM_PREFIX}/etc/gnutls/default-priorities
--with-unbound-root-key-file=$NEOTERM_PREFIX/etc/unbound/root.key
--with-included-libtasn1
--enable-local-libopts
--without-brotli
--without-p11-kit
--disable-guile
--disable-doc
"

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=30

	local a
	for a in LT_CURRENT LT_AGE; do
		local _${a}=$(sed -En 's/^\s*AC_SUBST\('"${a}"',\s*([0-9]+).*/\1/p' \
				m4/hooks.m4)
	done
	local v=$(( _LT_CURRENT - _LT_AGE ))
	if [ ! "${_LT_CURRENT}" ] || [ "${v}" != "${_SOVERSION}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}

neoterm_step_pre_configure() {
	CFLAGS+=" -DNO_INLINE_GETPASS=1"
}
