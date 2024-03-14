NEOTERM_PKG_HOMEPAGE=https://openldap.org
NEOTERM_PKG_DESCRIPTION="OpenLDAP server"
NEOTERM_PKG_LICENSE="OpenLDAP"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.6.7"
NEOTERM_PKG_SRCURL=https://www.openldap.org/software/download/OpenLDAP/openldap-release/openldap-${NEOTERM_PKG_VERSION}.tgz
NEOTERM_PKG_SHA256=cd775f625c944ed78a3da18a03b03b08eea73c8aabc97b41bb336e9a10954930
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libsasl, libuuid, openssl"
NEOTERM_PKG_BREAKS="openldap-dev"
NEOTERM_PKG_REPLACES="openldap-dev"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="STRIP="
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
ol_cv_lib_icu=no
ac_cv_func_memcmp_working=yes
--enable-dynamic
--with-yielding_select=yes
--enable-backends=no
--enable-monitor
--enable-mdb
--enable-ldap"

neoterm_step_pre_configure() {
	autoreconf -fi

	CFLAGS+=" -DMDB_USE_ROBUST=0"
	LDFLAGS+=" -lcrypto -llog"
}
