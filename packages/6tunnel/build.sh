NEOTERM_PKG_HOMEPAGE=https://github.com/wojtekka/6tunnel
NEOTERM_PKG_DESCRIPTION="Allows you to use services provided by IPv6 hosts with IPv4-only applications and vice-versa"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.13
NEOTERM_PKG_SRCURL=https://github.com/wojtekka/6tunnel/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=9f15ae24116ab2e781dc5a73faf9bb699b694cf845c9122ea755ab1780751f01

neoterm_step_pre_configure() {
	autoreconf -fi
}
