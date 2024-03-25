NEOTERM_PKG_HOMEPAGE=https://www.bacula.org
NEOTERM_PKG_DESCRIPTION="Bacula backup software"
NEOTERM_PKG_LICENSE="AGPL-V3"
NEOTERM_PKG_LICENSE_FILE="LICENSE"
NEOTERM_PKG_MAINTAINER="Matlink <matlink@matlink.fr>"
NEOTERM_PKG_VERSION=13.0.3
NEOTERM_PKG_SRCURL=https://sourceforge.net/projects/bacula/files/bacula/${NEOTERM_PKG_VERSION}/bacula-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=0949c32be1090585e88e4c01d828002e87603136d87c598a29dff42bb3ed2a40
NEOTERM_PKG_DEPENDS="libc++, liblzo, openssl, zlib"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_CONFFILES=etc/bacula/bacula-fd.conf
NEOTERM_PKG_SERVICE_SCRIPT=("bacula-fd" "${NEOTERM_PREFIX}/bin/bacula-fd")
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--sysconfdir=${NEOTERM_PREFIX}/etc/bacula
--with-plugindir=${NEOTERM_PREFIX}/lib/bacula
--mandir=${NEOTERM_PREFIX}/share/man
--with-logdir=${NEOTERM_PREFIX}/var/log
--with-working-dir=${NEOTERM_PREFIX}/var/run/bacula
--with-pid-dir=${NEOTERM_PREFIX}/var/run/bacula
--with-scriptdir=${NEOTERM_PREFIX}/etc/bacula/scripts
--with-lzo=${NEOTERM_PREFIX}
--with-ssl
--enable-smartalloc
--enable-conio
--enable-client-only
--with-baseport=9102
ac_cv_func_setpgrp_void=yes
"

neoterm_step_pre_configure() {
	LDFLAGS+=" $($CC -print-libgcc-file-name)"
	LDFLAGS+=" -Wl,-rpath=${NEOTERM_PREFIX}/lib/bacula -Wl,--enable-new-dtags"
}

neoterm_step_post_massage() {
	mkdir -p ${NEOTERM_PKG_MASSAGEDIR}${NEOTERM_PREFIX}/var/run/bacula
}
