NEOTERM_PKG_HOMEPAGE=https://www.xpdfreader.com/
NEOTERM_PKG_DESCRIPTION="Xpdf is an open source viewer for Portable Document Format (PDF) files."
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=4.04
NEOTERM_PKG_SRCURL=https://dl.xpdfreader.com/xpdf-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=63ce23fcbf76048f524c40be479ac3840d7a2cbadb6d1e0646ea77926656bade
NEOTERM_PKG_DEPENDS="fontconfig, freetype, libc++, libpng, qt5-qtbase, qt5-qtsvg"

# Remove files conflicting with poppler:
NEOTERM_PKG_RM_AFTER_INSTALL="
bin/pdfdetach
bin/pdffonts
bin/pdfimages
bin/pdfinfo
bin/pdftohtml
bin/pdftoppm
bin/pdftops
bin/pdftotext
share/man/man1/pdfdetach.1
share/man/man1/pdffonts.1
share/man/man1/pdfimages.1
share/man/man1/pdfinfo.1
share/man/man1/pdftohtml.1
share/man/man1/pdftoppm.1
share/man/man1/pdftops.1
share/man/man1/pdftotext.1
"
