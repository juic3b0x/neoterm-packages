NEOTERM_PKG_HOMEPAGE=https://gnunet.org/en/gnurl.html
NEOTERM_PKG_DESCRIPTION="Fork of libcurl, which is mostly for GNUnet"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=7.72.0
NEOTERM_PKG_SRCURL=https://ftp.gnu.org/gnu/gnunet/gnurl-$NEOTERM_PKG_VERSION.tar.Z
NEOTERM_PKG_SHA256=45b4e3cc1f052b2d56d076c276f65358e6f643b217d72b9a35e7a945f8601668
NEOTERM_PKG_DEPENDS="brotli, libgnutls, libidn2, libnettle, zlib, zstd"

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_func_getpwuid=yes
--disable-dict \
--disable-file \
--disable-ftp \
--disable-gopher \
--disable-imap \
--disable-ldap \
--disable-ldaps \
--disable-ntlm-wb \
--disable-pop3 \
--disable-rtsp \
--disable-smb \
--disable-smtp \
--disable-telnet \
--disable-tftp \
--enable-ipv6 \
--enable-manual \
--enable-versioned-symbols \
--enable-threaded-resolver \
--without-gssapi \
--with-gnutls \
--without-libidn \
--without-libpsl \
--without-librtmp \
--without-ssl \
--disable-ftp \
--disable-file \
--with-random=/dev/urandom \
--with-ca-bundle=$NEOTERM_PREFIX/etc/tls/cert.pem
--with-ca-path=$NEOTERM_PREFIX/etc/tls/certs
"
