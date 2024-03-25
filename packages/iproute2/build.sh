NEOTERM_PKG_HOMEPAGE=https://wiki.linuxfoundation.org/networking/iproute2
NEOTERM_PKG_DESCRIPTION="Utilities for controlling networking"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="6.7.0"
NEOTERM_PKG_SRCURL=https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=ff942dd9828d7d1f867f61fe72ce433078c31e5d8e4a78e20f02cb5892e8841d
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libandroid-glob, libandroid-support"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	CFLAGS+=" -fPIC"
	LDFLAGS+=" -landroid-glob"
}
