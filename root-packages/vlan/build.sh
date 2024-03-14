NEOTERM_PKG_HOMEPAGE=https://salsa.debian.org/debian/vlan
NEOTERM_PKG_DESCRIPTION="ifupdown integration for vlan configuration"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.0.5
NEOTERM_PKG_SRCURL=https://deb.debian.org/debian/pool/main/v/vlan/vlan_${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=ccf261839b79247be8dae93074e1c5fcbce3807787a0ff7aed4e1f7a9095c465
NEOTERM_PKG_DEPENDS="iproute2"
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin vconfig
	local f
	for f in network/{if-post-down.d/vlan,if-pre-up.d/vlan,if-up.d/ip}; do
		install -Dm700 -T debian/${f} $NEOTERM_PREFIX/etc/${f}
	done
	install -Dm600 -t $NEOTERM_PREFIX/share/man/man5 debian/vlan-interfaces.5
	install -Dm600 -t $NEOTERM_PREFIX/share/man/man8 vconfig.8
}
