NEOTERM_PKG_HOMEPAGE=http://www.squid-cache.org
NEOTERM_PKG_DESCRIPTION="Full-featured Web proxy cache server"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="6.8"
NEOTERM_PKG_SRCURL=https://github.com/squid-cache/squid/archive/refs/tags/SQUID_${NEOTERM_PKG_VERSION/./_}.tar.gz
NEOTERM_PKG_SHA256=9d14c7ca136c475cca9fbce07352bb4547549fdb873d5e854346735dab756c56
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP='\d+(_\d+)+'
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_DEPENDS="libc++, libcrypt, libexpat, libgnutls, libltdl, libnettle, libxml2, openldap, resolv-conf"

#disk-io uses XSI message queue which are not available on Android.
# Option 'cache_dir' will be unusable.
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_func_memrchr=yes
ac_cv_func_strtoll=yes
ac_cv_search_shm_open=
ac_cv_lib_sasl2_sasl_errstring=no
ac_cv_dbopen_libdb=no
squid_cv_gnu_atomics=yes
--datarootdir=$NEOTERM_PREFIX/share/squid
--libexecdir=$NEOTERM_PREFIX/libexec/squid
--mandir=$NEOTERM_PREFIX/share/man
--sysconfdir=$NEOTERM_PREFIX/etc/squid
--with-logdir=$NEOTERM_PREFIX/var/log/squid
--with-pidfile=$NEOTERM_PREFIX/var/run/squid.pid
--disable-external-acl-helpers
--disable-strict-error-checking
--enable-auth
--enable-auth-basic
--enable-auth-digest
--enable-auth-negotiate
--enable-auth-ntlm
--enable-delay-pools
--enable-linux-netfilter
--enable-removal-policies="lru,heap"
--enable-snmp
--disable-disk-io
--disable-storeio
--enable-translation
--with-dl
--without-openssl
--disable-ssl-crtd
--with-size-optimizations
--with-gnutls
--with-libnettle
--without-mit-krb5
--with-maxfd=256
"

neoterm_step_pre_configure() {
	# needed for building cf_gen
	export BUILDCXX=g++
	# else it picks up our cross CXXFLAGS
	export BUILDCXXFLAGS=' '
	autoreconf -fi
}

neoterm_step_post_massage() {
	# Ensure that necessary directories exist, otherwise squid fill fail.
	mkdir -p "$NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX/var/cache/squid"
	mkdir -p "$NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX/var/log/squid"
	mkdir -p "$NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX/var/run"
}
