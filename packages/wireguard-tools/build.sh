NEOTERM_PKG_HOMEPAGE=https://www.wireguard.com
NEOTERM_PKG_DESCRIPTION="Tools for the WireGuard secure network tunnel"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.0.20210914
NEOTERM_PKG_SRCURL=https://git.zx2c4.com/wireguard-tools/snapshot/wireguard-tools-$NEOTERM_PKG_VERSION.tar.xz
NEOTERM_PKG_SHA256=97ff31489217bb265b7ae850d3d0f335ab07d2652ba1feec88b734bc96bd05ac
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_MAKE_ARGS=" -C src WITH_BASHCOMPLETION=yes WITH_WGQUICK=no WITH_SYSTEMDUNITS=no"

neoterm_step_post_make_install() {
	cd src/wg-quick
	$CC $CFLAGS $LDFLAGS -DWG_CONFIG_SEARCH_PATHS="\"$NEOTERM_ANDROID_HOME/.wireguard $NEOTERM_PREFIX/etc/wireguard /data/misc/wireguard /data/data/com.wireguard.android/files\"" -o wg-quick android.c
	install -Dm0700 wg-quick $NEOTERM_PREFIX/bin/wg-quick
}
