NEOTERM_PKG_HOMEPAGE=https://www.cups-pdf.de/
NEOTERM_PKG_DESCRIPTION="CUPS PDF backend"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.0.1
NEOTERM_PKG_SRCURL=https://www.cups-pdf.de/src/cups-pdf_${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=738669edff7f1469fe5e411202d87f93ba25b45f332a623fb607d49c59aa9531
NEOTERM_PKG_DEPENDS="cups, ghostscript"
NEOTERM_PKG_CONFFILES="etc/cups/cups-pdf.conf"

neoterm_step_make() {
	$CC $CFLAGS $CPPFLAGS $NEOTERM_PKG_SRCDIR/src/cups-pdf.c \
		-o cups-pdf $LDFLAGS -lcups
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/lib/cups/backend \
		cups-pdf
	install -Dm600 -t $NEOTERM_PREFIX/etc/cups \
		$NEOTERM_PKG_SRCDIR/extra/cups-pdf.conf
	install -Dm600 -t $NEOTERM_PREFIX/share/cups/model \
		$NEOTERM_PKG_SRCDIR/extra/CUPS-PDF_opt.ppd
}
