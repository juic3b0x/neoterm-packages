NEOTERM_PKG_HOMEPAGE=https://openvpn.net
NEOTERM_PKG_DESCRIPTION="An easy-to-use, robust, and highly configurable VPN (Virtual Private Network)"
# License: GPL-2.0-with-OpenSSL-exception
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.6.9"
NEOTERM_PKG_SRCURL=https://github.com/OpenVPN/openvpn/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=96a7a63aeea1f64b0ea662ef29aa13b2b4f8fe8cdc8f062a5242362bb63b2231
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libcap-ng, liblz4, liblzo, net-tools, openssl"
NEOTERM_PKG_BUILD_IN_SRC=true

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-plugin-auth-pam
--disable-systemd
--disable-debug
--enable-iproute2
--enable-small
--enable-x509-alt-username
ac_cv_func_getpwnam=yes
IFCONFIG=$NEOTERM_PREFIX/bin/ifconfig
ROUTE=$NEOTERM_PREFIX/bin/route
IPROUTE=$NEOTERM_PREFIX/bin/ip
NETSTAT=$NEOTERM_PREFIX/bin/netstat
"

neoterm_step_pre_configure() {
	autoreconf -fi
}

neoterm_step_post_make_install() {
	# Examples.
	install -d -m700 "$NEOTERM_PREFIX/share/openvpn/examples"
	cp "$NEOTERM_PKG_SRCDIR"/sample/sample-config-files/* "$NEOTERM_PREFIX/share/openvpn/examples"
}
