NEOTERM_PKG_HOMEPAGE=https://www.yoctoproject.org/tools-resources/projects/matchbox
NEOTERM_PKG_DESCRIPTION="X virtual keyboard library."
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.3
NEOTERM_PKG_REVISION=21
NEOTERM_PKG_SRCURL=https://git.yoctoproject.org/cgit/cgit.cgi/libfakekey/snapshot/libfakekey-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=d282fa6481a5b85f71e36e8bad4cfa938cc8eaac4c42ffa27f9203ac634813f4
NEOTERM_PKG_DEPENDS="libx11, libxtst"
NEOTERM_PKG_EXTRA_MAKE_ARGS="AM_LDFLAGS=-lX11"

neoterm_step_pre_configure() {
	autoreconf -i
}
