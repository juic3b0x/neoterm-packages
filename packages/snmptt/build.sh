NEOTERM_PKG_HOMEPAGE=http://www.snmptt.org/
NEOTERM_PKG_DESCRIPTION="SNMP trap translator"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.5
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/snmptt/snmptt_${NEOTERM_PKG_VERSION}.tgz
NEOTERM_PKG_SHA256=91fb6146a08c0d143e4193f1fffdb697f769f75666d72a73eeb78c013b8a227f
NEOTERM_PKG_DEPENDS="net-snmp, perl"
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	find . -maxdepth 1 -type f -name 'snmptt*' | xargs -n 1 sed -i \
		-e 's:\([^A-Za-z0-9.]\)/etc/:\1'$NEOTERM_PREFIX'/etc/:g' \
		-e 's:\([^A-Za-z0-9.]\)/sbin/:\1'$NEOTERM_PREFIX'/bin/:g' \
		-e 's:\([^A-Za-z0-9.]\)/usr/sbin/:\1'$NEOTERM_PREFIX'/bin/:g' \
		-e 's:\([^A-Za-z0-9.]\)/var/:\1'$NEOTERM_PREFIX'/var/:g' \
		-e 's:\([^A-Za-z0-9.]\)/usr/local/etc/:\1'$NEOTERM_PREFIX'/local/etc/:g'
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin \
		snmptt snmptt-net-snmp-test \
		snmpttconvert snmpttconvertmib \
		snmptthandler snmptthandler-embedded
	install -Dm600 -t $NEOTERM_PREFIX/share/snmptt/examples examples/*
	install -Dm600 -t $NEOTERM_PREFIX/etc/snmptt snmptt.ini
	install -Dm600 -T examples/snmptt.conf.generic \
		$NEOTERM_PREFIX/etc/snmptt/snmptt.conf
}
