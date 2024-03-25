NEOTERM_PKG_HOMEPAGE=https://pdfgrep.org/
NEOTERM_PKG_DESCRIPTION="Command line utility to search text in PDF files"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.1.2
NEOTERM_PKG_REVISION=16
NEOTERM_PKG_SRCURL=https://pdfgrep.org/download/pdfgrep-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=0ef3dca1d749323f08112ffe68e6f4eb7bc25f56f90a2e933db477261b082aba
NEOTERM_PKG_DEPENDS="libc++, libgcrypt, libgpg-error, pcre, poppler"

neoterm_step_pre_configure() {
	CXXFLAGS+=" -std=c++17"
}
