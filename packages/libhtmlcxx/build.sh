NEOTERM_PKG_HOMEPAGE=https://htmlcxx.sourceforge.net/
NEOTERM_PKG_DESCRIPTION="A simple non-validating css1 and html parser for C++"
NEOTERM_PKG_LICENSE="LGPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.87
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=http://downloads.sourceforge.net/sourceforge/htmlcxx/htmlcxx-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=5d38f938cf4df9a298a5346af27195fffabfef9f460fc2a02233cbcfa8fc75c8
NEOTERM_PKG_DEPENDS="libc++, libiconv"

neoterm_step_pre_configure() {
	autoreconf -fi

	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
