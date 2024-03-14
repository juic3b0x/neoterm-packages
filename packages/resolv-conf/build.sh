NEOTERM_PKG_HOMEPAGE=https://man7.org/linux/man-pages/man5/resolv.conf.5.html
NEOTERM_PKG_DESCRIPTION="Resolver configuration file"
NEOTERM_PKG_LICENSE="Public Domain"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.3
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_SKIP_SRC_EXTRACT=true

NEOTERM_PKG_CONFFILES="
etc/hosts
etc/resolv.conf
"

neoterm_step_make_install() {
	printf "127.0.0.1 localhost\n::1 ip6-localhost\n" > $NEOTERM_PREFIX/etc/hosts
	printf "nameserver 8.8.8.8\nnameserver 8.8.4.4\n" > $NEOTERM_PREFIX/etc/resolv.conf
}
