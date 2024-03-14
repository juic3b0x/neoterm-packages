NEOTERM_PKG_HOMEPAGE=https://www.lighttpd.net
NEOTERM_PKG_DESCRIPTION="Fast webserver with minimal memory footprint"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.4.74"
NEOTERM_PKG_SRCURL=https://download.lighttpd.net/lighttpd/releases-1.4.x/lighttpd-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=5c08736e83088f7e019797159f306e88ec729abe976dc98fb3bed71b9d3e53b5
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libandroid-glob, libbz2, libcrypt, openssl, pcre2, zlib"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dwith_bzip=enabled
-Dwith_openssl=true
-Dwith_zlib=enabled
"
NEOTERM_PKG_RM_AFTER_INSTALL="bin/lighttpd-angel"
NEOTERM_PKG_SERVICE_SCRIPT=("lighttpd" "if [ -f \"$NEOTERM_ANDROID_HOME/.lighttpd/lighttpd.conf\" ]; then CONFIG=\"$NEOTERM_ANDROID_HOME/.lighttpd/lighttpd.conf\"; else CONFIG=\"$NEOTERM_PREFIX/etc/lighttpd/lighttpd.conf\"; fi\nexec lighttpd -D -f \$CONFIG 2>&1")

NEOTERM_PKG_CONFFILES="
etc/lighttpd/lighttpd.conf
etc/lighttpd/modules.conf
"

neoterm_step_post_get_source() {
	mv configure{,.unused}
	mv CMakeLists.txt{,.unused}
}

neoterm_step_pre_configure() {
	LDFLAGS="$LDFLAGS -landroid-glob"
}

neoterm_step_post_make_install() {
	# Install example config file
	install -Dm600 -t $NEOTERM_PREFIX/etc/lighttpd/ \
		$NEOTERM_PKG_SRCDIR/doc/config/lighttpd.conf \
		$NEOTERM_PKG_SRCDIR/doc/config/modules.conf
	install -Dm600 -t $NEOTERM_PREFIX/etc/lighttpd/conf.d \
		$NEOTERM_PKG_SRCDIR/doc/config/conf.d/*.conf
	install -Dm600 -t $NEOTERM_PREFIX/etc/lighttpd/vhosts.d \
		$NEOTERM_PKG_SRCDIR/doc/config/vhosts.d/vhosts.template

	cd $NEOTERM_PKG_SRCDIR/doc/config
	NEOTERM_PKG_CONFFILES+="$(find conf.d -type f -iname "*.conf" | sed -E 's/(.*)/etc\/lighttpd\/\1/g')"
}
