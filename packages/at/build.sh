NEOTERM_PKG_HOMEPAGE=https://salsa.debian.org/debian/at
NEOTERM_PKG_DESCRIPTION="AT and batch delayed command scheduling utility and daemon"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.2.5
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_SRCURL=https://deb.debian.org/debian/pool/main/a/at/at_${NEOTERM_PKG_VERSION}.orig.tar.gz
NEOTERM_PKG_SHA256=bb066b389d7c9bb9d84a35738032b85c30cba7d949f758192adc72c9477fd3b8
NEOTERM_PKG_SUGGESTS="neoterm-services"
NEOTERM_PKG_BUILD_IN_SRC=true

# Force make -j1.
NEOTERM_MAKE_PROCESSES=1

# Setting loadavg_mx to 8.0 as most devices (8 core)
# do not have loadavg below 5-6.
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_path_SENDMAIL=$NEOTERM_PREFIX/bin/sendmail
--with-loadavg_mx=8.0
--with-etcdir=$NEOTERM_PREFIX/etc
--with-jobdir=$NEOTERM_PREFIX/var/spool/atd
--with-atspool=$NEOTERM_PREFIX/var/spool/atd
"

# at.allow and at.deny are not supported in NeoTerm.
NEOTERM_PKG_RM_AFTER_INSTALL="
share/man/man5
"

NEOTERM_PKG_SERVICE_SCRIPT=("atd" "mkdir -p $NEOTERM_PREFIX/var/run && exec atd")

neoterm_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!${NEOTERM_PREFIX}/bin/sh
	mkdir -p $NEOTERM_PREFIX/var/run
	EOF
}
