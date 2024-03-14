NEOTERM_PKG_HOMEPAGE=https://yuma123.org/
NEOTERM_PKG_DESCRIPTION="Provides an opensource YANG API in C"
NEOTERM_PKG_LICENSE="BSD 3-Clause, MIT, Public Domain"
NEOTERM_PKG_LICENSE_FILE="debian/copyright"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.13
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/yuma123/yuma123_${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=e304b253236a279f10b133fdd19f366f271581ebf12647cea84667fcfada1f0c
NEOTERM_PKG_DEPENDS="libssh2, libxml2, openssl, readline"

neoterm_step_pre_configure() {
	autoreconf -fi

	CPPFLAGS+=" -D__USE_BSD"
}
