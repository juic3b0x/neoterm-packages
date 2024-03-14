NEOTERM_PKG_HOMEPAGE=https://www.w3.org/Tools/HTML-XML-utils/
NEOTERM_PKG_DESCRIPTION="A number of simple utilities for manipulating HTML and XML files"
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="COPYING"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=8.6
NEOTERM_PKG_SRCURL=https://www.w3.org/Tools/HTML-XML-utils/html-xml-utils-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=5e84729ef36ccd3924d2872ed4ee6954c63332dca5400ba8eb4eaef1f2db4fb2
NEOTERM_PKG_DEPENDS="libcurl, libiconv, libidn2"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	autoreconf -fi

	CPPFLAGS+=" -D__USE_BSD"
}
