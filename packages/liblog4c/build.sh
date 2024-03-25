NEOTERM_PKG_HOMEPAGE=https://log4c.sourceforge.net/
NEOTERM_PKG_DESCRIPTION="A C library for flexible logging to files, syslog and other destinations"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.2.4
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=http://prdownloads.sourceforge.net/log4c/log4c-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=5991020192f52cc40fa852fbf6bbf5bd5db5d5d00aa9905c67f6f0eadeed48ea
NEOTERM_PKG_DEPENDS="libexpat"

neoterm_step_pre_configure() {
	autoreconf -fi
}
