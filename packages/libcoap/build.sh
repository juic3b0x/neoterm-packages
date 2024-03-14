NEOTERM_PKG_HOMEPAGE=https://libcoap.net/
NEOTERM_PKG_DESCRIPTION="Implementation of CoAP, a lightweight protocol for resource constrained devices"
NEOTERM_PKG_LICENSE="BSD 2-Clause"
NEOTERM_PKG_LICENSE_FILE="COPYING, LICENSE"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="4.3.4a"
NEOTERM_PKG_SRCURL=https://github.com/obgm/libcoap/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=45f1aabbb5f710e841c91d65fc3f37c906d42e8fc44dd04979e767d3960a77cf
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_DEPENDS="openssl"
NEOTERM_PKG_BREAKS="libcoap-dev"
NEOTERM_PKG_REPLACES="libcoap-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--with-openssl --disable-doxygen"

neoterm_step_pre_configure() {
	NOCONFIGURE=1 ./autogen.sh
}
