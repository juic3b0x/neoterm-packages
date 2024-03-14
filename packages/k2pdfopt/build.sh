NEOTERM_PKG_HOMEPAGE=https://www.willus.com/k2pdfopt/
NEOTERM_PKG_DESCRIPTION="A tool that optimizes PDF files for viewing on mobile readers"
NEOTERM_PKG_LICENSE="AGPL-V3"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.54
NEOTERM_PKG_REVISION=4
NEOTERM_PKG_SRCURL=https://www.willus.com/k2pdfopt/src/k2pdfopt_v${NEOTERM_PKG_VERSION}_src.zip
NEOTERM_PKG_SHA256=43490a55bdaecdd2300276221b6a713b754e7c617e80481191c04c67b3357b38
NEOTERM_PKG_DEPENDS="djvulibre, gsl, leptonica, libjasper, libjpeg-turbo, libpng, mupdf, zlib"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	CPPFLAGS+=" -DHAVE_MUPDF_LIB=1"
	LDFLAGS+=" -lmupdf"
}
