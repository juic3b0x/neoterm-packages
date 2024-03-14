NEOTERM_PKG_HOMEPAGE=https://transmissionbt.com/
NEOTERM_PKG_DESCRIPTION="Easy, lean and powerful BitTorrent client"
# with OpenSSL linking exception:
NEOTERM_PKG_LICENSE="GPL-2.0, GPL-3.0"
NEOTERM_PKG_LICENSE_FILE="COPYING, licenses/gpl-2.0.txt, licenses/gpl-3.0.txt"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="4.0.5"
NEOTERM_PKG_SRCURL=git+https://github.com/transmission/transmission
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_GIT_BRANCH=$NEOTERM_PKG_VERSION
NEOTERM_PKG_DEPENDS="libc++, libcurl, libevent, libpsl, miniupnpc, natpmpc, openssl"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DENABLE_GTK=OFF
-DENABLE_QT=OFF
-DENABLE_TESTS=OFF
-DENABLE_NLS=OFF
"
# transmission already puts timestamps in the info printed to stdout so no need for svlogd -tt,
# therefore we override the transmission/log run script
NEOTERM_PKG_SERVICE_SCRIPT=(
	"transmission" 'exec transmission-daemon -f 2>&1'
	"transmission/log" 'mkdir -p "$LOGDIR/sv/transmission"\nexec svlogd "$LOGDIR/sv/transmission"'
)

neoterm_step_pre_configure() {
	LDFLAGS+=" -llog"
}
