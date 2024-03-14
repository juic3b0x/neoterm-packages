NEOTERM_PKG_HOMEPAGE=https://www.musicpd.org/clients/mpdscribble/
NEOTERM_PKG_DESCRIPTION="A Music Player Daemon (MPD) client which submits information about tracks being played to a scrobbler"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="Henrik Grimler @Grimler91"
NEOTERM_PKG_VERSION="0.25"
NEOTERM_PKG_SRCURL=https://github.com/MusicPlayerDaemon/mpdscribble/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=ce24145df6657f1d8070c88f6795f567f21ff9126b0740c088f40344fc496b1e
NEOTERM_PKG_DEPENDS="libc++, libcurl, libgcrypt, mpd, libmpdclient, glib"
NEOTERM_PKG_BUILD_DEPENDS="boost, boost-headers"
NEOTERM_PKG_CONFFILES="etc/mpdscribble.conf"
# mpdscribble already puts timestamps in the info printed to stdout so no need for svlogd -tt,
# therefore we override the mpdscribble/log run script
NEOTERM_PKG_SERVICE_SCRIPT=(
	"mpdscribble" "if [ -f \"$NEOTERM_ANDROID_HOME/.mpdscribble/mpdscribble.conf\" ]; then CONFIG=\"$NEOTERM_ANDROID_HOME/.mpdscribble/mpdscribble.conf\"; else CONFIG=\"$NEOTERM_PREFIX/etc/mpdscribble.conf\"; fi\nexec mpdscribble -D --log /proc/self/fd/1 --conf \$CONFIG"
	"mpdscribble/log" 'mkdir -p "$LOGDIR/sv/mpdscribble"\nexec svlogd "$LOGDIR/sv/mpdscribble"'
)
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"

neoterm_step_pre_configure() {
	export BOOST_ROOT=$NEOTERM_PREFIX
}

neoterm_step_post_make_install () {
	install $NEOTERM_PKG_SRCDIR/doc/mpdscribble.conf $NEOTERM_PREFIX/etc/
}

neoterm_step_create_debscripts () {
	echo "#!$NEOTERM_PREFIX/bin/sh" > postinst
	echo "mkdir -p ~/.mpdscribble" >> postinst
	echo "exit 0" >> postinst
	chmod 0755 postinst
}
