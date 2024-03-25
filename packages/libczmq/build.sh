NEOTERM_PKG_HOMEPAGE=https://zeromq.org/
NEOTERM_PKG_DESCRIPTION="High-level C binding for ZeroMQ"
NEOTERM_PKG_LICENSE="MPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=4.2.1
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://github.com/zeromq/czmq/releases/download/v${NEOTERM_PKG_VERSION}/czmq-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=5d720a204c2a58645d6f7643af15d563a712dad98c9d32c1ed913377daa6ac39
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="liblz4, libuuid, libzmq"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--enable-drafts=no"

neoterm_step_pre_configure() {
	CFLAGS+=" -DCZMQ_HAVE_ANDROID=1"
	LDFLAGS+=" -llog"
	autoconf
}
