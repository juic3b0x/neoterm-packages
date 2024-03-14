NEOTERM_PKG_HOMEPAGE=https://github.com/libxls/libxls
NEOTERM_PKG_DESCRIPTION="A C library for reading Excel files in the nasty old binary OLE format"
NEOTERM_PKG_LICENSE="BSD 2-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.6.2
NEOTERM_PKG_SRCURL=https://github.com/libxls/libxls/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=2f836fcef6372c6bc882c3e80bfd3043812e2fc4d4534022a25b24fe801b1770

neoterm_step_pre_configure() {
	autoreconf -fi
}
