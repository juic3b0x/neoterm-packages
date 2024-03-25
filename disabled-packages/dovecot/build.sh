NEOTERM_PKG_HOMEPAGE=https://www.dovecot.org
NEOTERM_PKG_DESCRIPTION="Secure IMAP and POP3 email server"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="Vishal Biswas @vishalbiswas"
NEOTERM_PKG_VERSION=2.2.31
NEOTERM_PKG_SRCURL=https://www.dovecot.org/releases/2.2/dovecot-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=034be40907748128d65088a4f59789b2f99ae7b33a88974eae0b6a68ece376a1
NEOTERM_PKG_DEPENDS="openssl, libcrypt"
# turning on icu gives undefined reference to __cxa_call_unexpected
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--with-zlib
--with-ssl=openssl
--with-ssldir=$NEOTERM_PREFIX/etc/tls
--without-icu
--without-shadow
i_cv_epoll_works=yes
i_cv_posix_fallocate_works=yes
i_cv_signed_size_t=no
i_cv_gmtime_max_time_t=40
i_cv_signed_time_t=yes
i_cv_mmap_plays_with_write=yes
i_cv_fd_passing=yes
i_cv_c99_vsnprintf=yes
lib_cv_va_copy=yes
lib_cv___va_copy=yes
"

neoterm_step_pre_configure() {
	LDFLAGS="$LDFLAGS -llog"

	for i in $(find $NEOTERM_PKG_SRCDIR/src/director -type f); do sed 's|\bstruct user\b|struct usertest|g' -i $i; done

	if [ "$NEOTERM_ARCH" == "aarch64" ]; then
		NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+="lib_cv_va_val_copy=yes"
	else
		NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+="lib_cv_va_val_copy=no"
	fi
}

neoterm_step_post_make_install() {
	for binary in doveadm doveconf; do
		mv $NEOTERM_PREFIX/bin/$binary $NEOTERM_PREFIX/libexec/dovecot/$binary
		cat > $NEOTERM_PREFIX/bin/$binary <<HERE
#!$NEOTERM_PREFIX/bin/sh
export LD_LIBRARY_PATH=$NEOTERM_PREFIX/lib/dovecot:\$LD_LIBRARY_PATH
exec $NEOTERM_PREFIX/libexec/dovecot/$binary $@
HERE
		chmod u+x $NEOTERM_PREFIX/bin/$binary
	done
}
