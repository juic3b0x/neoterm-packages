NEOTERM_PKG_HOMEPAGE=https://libcddb.sourceforge.net/
NEOTERM_PKG_DESCRIPTION="A C library to access data on a CDDB server"
NEOTERM_PKG_LICENSE="LGPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.3.2
NEOTERM_PKG_SRCURL=http://prdownloads.sourceforge.net/libcddb/libcddb-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=35ce0ee1741ea38def304ddfe84a958901413aa829698357f0bee5bb8f0a223b
NEOTERM_PKG_DEPENDS="libiconv"

neoterm_step_pre_configure() {
	autoreconf -fi
}
