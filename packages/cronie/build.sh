NEOTERM_PKG_HOMEPAGE=https://github.com/cronie-crond/cronie/
NEOTERM_PKG_DESCRIPTION="Daemon that runs specified programs at scheduled times and related tools"
NEOTERM_PKG_LICENSE="ISC, BSD 2-Clause, BSD 3-Clause, GPL-2.0, LGPL-2.1"
NEOTERM_PKG_LICENSE_FILE="COPYING, COPYING.obstack"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.7.1"
NEOTERM_PKG_SRCURL=https://github.com/cronie-crond/cronie/releases/download/cronie-${NEOTERM_PKG_VERSION}/cronie-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=78033100c24413f0c40f93e6138774d6a4f55bc31050567b90db45a2f9f1b954
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
NEOTERM_PKG_DEPENDS="dash"
NEOTERM_PKG_RECOMMENDS="nano"
NEOTERM_PKG_SUGGESTS="neoterm-services"
NEOTERM_PKG_CONFLICTS="busybox (<< 1.31.1-11)"

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-anacron
--disable-pam
--with-editor=$NEOTERM_PREFIX/bin/nano
"

NEOTERM_PKG_SERVICE_SCRIPT=("crond" 'exec crond -n -s')

neoterm_step_post_get_source() {
    sed -i "s|\"/usr/sbin/sendmail\"|\"${NEOTERM_PREFIX}/bin/sendmail\"|" ${NEOTERM_PKG_SRCDIR}/configure
    sed -i "s|\"/usr/sbin/sendmail\"|\"${NEOTERM_PREFIX}/bin/sendmail\"|" ${NEOTERM_PKG_SRCDIR}/src/cron.c
    sed -i "s|\"/tmp\"|\"${NEOTERM_PREFIX}/tmp\"|" ${NEOTERM_PKG_SRCDIR}/src/crontab.c
    sed -i "s|_PATH_BSHELL \"/bin/sh\"|_PATH_BSHELL \"${NEOTERM_PREFIX}/bin/sh\"|" ${NEOTERM_PKG_SRCDIR}/src/crontab.c
    sed -i "s|_PATH_STDPATH \"/usr/bin:/bin:/usr/sbin:/sbin\"|_PATH_STDPATH \"${NEOTERM_PREFIX}/bin\"|" ${NEOTERM_PKG_SRCDIR}/src/crontab.c
    sed -i "s|_PATH_TMP \"/tmp\"|_PATH_TMP \"${NEOTERM_PREFIX}/tmp\"|" ${NEOTERM_PKG_SRCDIR}/src/crontab.c
    sed -i "s|getdtablesize()|sysconf(_SC_OPEN_MAX)|" ${NEOTERM_PKG_SRCDIR}/src/do_command.c
    sed -i "s|getdtablesize()|sysconf(_SC_OPEN_MAX)|" ${NEOTERM_PKG_SRCDIR}/src/popen.c
}

neoterm_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$NEOTERM_PREFIX/bin/sh
	mkdir -p $NEOTERM_PREFIX/var/run
	mkdir -p $NEOTERM_PREFIX/var/spool/cron
	mkdir -p $NEOTERM_PREFIX/etc/cron.d
	EOF
}
