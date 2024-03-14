NEOTERM_PKG_HOMEPAGE=https://hostap.epitest.fi/wpa_supplicant
NEOTERM_PKG_DESCRIPTION="Utility providing key negotiation for WPA wireless networks"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.10
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://w1.fi/releases/wpa_supplicant-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_DEPENDS="openssl, readline, libnl"
NEOTERM_PKG_SHA256=20df7ae5154b3830355f8ab4269123a87affdea59fe74fe9292a91d0d7e17b2f
NEOTERM_PKG_EXTRA_MAKE_ARGS="-C wpa_supplicant"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_post_configure() {
	cp wpa_supplicant/defconfig wpa_supplicant/.config
	export EXTRA_CFLAGS=$CPPFLAGS
}

neoterm_step_post_make_install() {
	mkdir -p $NEOTERM_PREFIX/share/man/{man5,man8}
	install -m600 wpa_supplicant/doc/docbook/wpa_supplicant.conf.5 $NEOTERM_PREFIX/share/man/man5/
	install -m600 wpa_supplicant/doc/docbook/{wpa_cli,wpa_supplicant}.8 $NEOTERM_PREFIX/share/man/man8/
}
