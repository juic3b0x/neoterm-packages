NEOTERM_PKG_HOMEPAGE=http://ftp.linux.org.uk/pub/linux/Networking/netkit/
NEOTERM_PKG_DESCRIPTION="User information lookup program"
NEOTERM_PKG_LICENSE="BSD"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.17
NEOTERM_PKG_SRCURL=http://ftp.linux.org.uk/pub/linux/Networking/netkit/bsd-finger-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=84885d668d117ef50e01c7034a45d8343d747cec6212e40e8d08151bc18e13fa
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_post_get_source() {
	sed -n '1,/*\//p' finger/finger.c > LICENSE
}

neoterm_step_configure() {
	./configure
}
