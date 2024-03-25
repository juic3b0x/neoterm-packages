NEOTERM_PKG_HOMEPAGE=http://www.net-snmp.org/
NEOTERM_PKG_DESCRIPTION="Various tools relating to the Simple Network Management Protocol"
# Licenses: HPND, BSD 3-Clause, MIT
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="COPYING"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="5.9.4"
NEOTERM_PKG_SRCURL=https://github.com/net-snmp/net-snmp/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=0699e7effc5782124c1fa2f2823d816ae740fac5bef002440edfee86b17c1aba
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--with-agentx-socket=$NEOTERM_PREFIX/var/agentx/master
--with-default-snmp-version=3
--with-logfile=$NEOTERM_PREFIX/var/log/net-snmpd.log
--with-mnttab=$NEOTERM_PREFIX/etc/mtab
--with-persistent-directory=$NEOTERM_PREFIX/var/lib/net-snmp
--with-sys-contact=root@localhost
--with-sys-location=Unknown
--with-temp-file-pattern=$NEOTERM_PREFIX/tmp/snmpdXXXXXX
ac_cv_path_LPSTAT_PATH=$NEOTERM_PREFIX/bin/lpstat
"

neoterm_step_pre_configure() {
	if [ $NEOTERM_ARCH = "x86_64" ]; then
		CPPFLAGS+=" -DOPENSSL_NO_INLINE_ASM"
	fi
}
