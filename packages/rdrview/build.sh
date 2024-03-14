NEOTERM_PKG_HOMEPAGE=https://github.com/eafer/rdrview
NEOTERM_PKG_DESCRIPTION="Command line tool to extract the main content from a webpage"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1:0.1.1
NEOTERM_PKG_SRCURL=https://github.com/eafer/rdrview/archive/refs/tags/v${NEOTERM_PKG_VERSION#*:}.tar.gz
NEOTERM_PKG_SHA256=4655d77fd74f0cb89acf6f72a3be445265da6c948f30c29eb8ee2bb8d6df3f63
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_DEPENDS="libcurl, libiconv, libseccomp, libxml2"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	LDFLAGS+=" -liconv"
}
