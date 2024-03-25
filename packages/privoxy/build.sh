NEOTERM_PKG_HOMEPAGE=https://www.privoxy.org
NEOTERM_PKG_DESCRIPTION="Non-caching web proxy with advanced filtering capabilities"
# License: GPL-2.0-or-later
NEOTERM_PKG_LICENSE="GPL-2.0, GPL-3.0"
NEOTERM_PKG_LICENSE_FILE="LICENSE, LICENSE.GPLv3"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.0.34
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/project/ijbswa/Sources/$NEOTERM_PKG_VERSION%20%28stable%29/privoxy-$NEOTERM_PKG_VERSION-stable-src.tar.gz
NEOTERM_PKG_SHA256=e6ccbca1656f4e616b4657f8514e33a70f6697e9d7294356577839322a3c5d2c
# NeoTerm-services adds the run scripts to NEOTERM_PKG_CONFFILES. Those ones can
# not be copied in neoterm_step_post_massage so setup special variable for that
DEFAULT_CONFFILES="\
etc/privoxy/config
etc/privoxy/match-all.action
etc/privoxy/trust
etc/privoxy/user.action
etc/privoxy/user.filter
etc/privoxy/default.action
etc/privoxy/default.filter"
NEOTERM_PKG_CONFFILES=$DEFAULT_CONFFILES
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_lib_pcreposix_regcomp=no
--sysconfdir=$NEOTERM_PREFIX/etc/privoxy
"
NEOTERM_PKG_DEPENDS="pcre, libpcreposix, zlib"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_SERVICE_SCRIPT=("privoxy"
"if [ -f \"$NEOTERM_ANDROID_HOME/.config/privoxy/config\" ]; then \
CONFIG=\"$NEOTERM_ANDROID_HOME/.config/privoxy/config\"; else \
CONFIG=\"$NEOTERM_PREFIX/etc/privoxy/config\"; fi\n\
exec privoxy --no-daemon \$CONFIG 2>&1")

neoterm_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $NEOTERM_PREFIX.
	if $NEOTERM_ON_DEVICE_BUILD; then
		neoterm_error_exit "Package '$NEOTERM_PKG_NAME' is not safe for on-device builds."
	fi

	autoheader
	autoconf
}

neoterm_step_post_massage() {
	# copy default config files
	for f in $DEFAULT_CONFFILES; do
		cp "$NEOTERM_PKG_SRCDIR/$(basename $f)" \
			"$NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX/$f"
	done
}
