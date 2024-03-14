NEOTERM_PKG_HOMEPAGE=https://www.cyrusimap.org/sasl/
NEOTERM_PKG_DESCRIPTION="Cyrus SASL - authentication abstraction library"
NEOTERM_PKG_LICENSE="BSD"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.1.28
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://fossies.org/linux/misc/cyrus-sasl-$NEOTERM_PKG_VERSION.tar.xz
NEOTERM_PKG_SHA256=67f1945057d679414533a30fe860aeb2714f5167a8c03041e023a65f629a9351
NEOTERM_PKG_BREAKS="libsasl-dev"
NEOTERM_PKG_REPLACES="libsasl-dev"
# Seems to be race issues in build (symlink creation)::
NEOTERM_MAKE_PROCESSES=1
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
lt_cv_deplibs_check_method=pass_all
ac_cv_func_syslog=no
ac_cv_header_syslog_h=no
--disable-gssapi
--disable-otp
--sysconfdir=$NEOTERM_PREFIX/etc
--with-dblib=none
--with-dbpath=$NEOTERM_PREFIX/var/lib/sasldb
--without-des
--without-saslauthd
--with-plugindir=$NEOTERM_PREFIX/lib/sasl2
--enable-login
"
NEOTERM_PKG_RM_AFTER_INSTALL="bin/pluginviewer"

neoterm_step_pre_configure() {
	autoreconf -fi
}

neoterm_step_post_massage() {
	for sub in anonymous crammd5 digestmd5 plain login; do
		local base=lib/sasl2/lib${sub}
		if [ ! -f ${base}.so ]; then
			neoterm_error_exit "libsasl not packaged with $base"
		fi
	done
}
