NEOTERM_PKG_HOMEPAGE=https://www.torproject.org
NEOTERM_PKG_DESCRIPTION="The Onion Router anonymizing overlay network"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.4.8.10"
NEOTERM_PKG_SRCURL=https://www.torproject.org/dist/tor-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=e628b4fab70edb4727715b23cf2931375a9f7685ac08f2c59ea498a178463a86
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libevent, liblzma, openssl, resolv-conf, zlib"
NEOTERM_PKG_BUILD_DEPENDS="libandroid-glob"
# We're not using '--enable-android' as it just defines 'USE_ANDROID', which
# makes Tor writes the log to Android's logcat instead of to stdout/stderr, not
# helpful in our case. Although it would be good to go through the source and
# ensure that in future there is not any other Android specific behaviour which
# affects security/anonymity.
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--disable-zstd --disable-unittests"
NEOTERM_PKG_CONFFILES="etc/tor/torrc"
NEOTERM_PKG_SERVICE_SCRIPT=("tor" 'exec tor 2>&1')

neoterm_step_post_make_install() {
	# use default config
	mv "$NEOTERM_PREFIX/etc/tor/torrc.sample" "$NEOTERM_PREFIX/etc/tor/torrc"
}
