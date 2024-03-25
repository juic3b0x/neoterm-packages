NEOTERM_PKG_HOMEPAGE=https://sourceforge.net/projects/vbisam/
NEOTERM_PKG_DESCRIPTION="A replacement for IBM's C-ISAM"
NEOTERM_PKG_LICENSE="GPL-2.0, LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.0
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/project/vbisam/vbisam2/vbisam-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=688b776e0030cce50fd7e44cbe40398ea93431f76510c7100433cc6313eabc4f

neoterm_step_pre_configure() {
	cp $NEOTERM_PKG_BUILDER_DIR/efgcvt_r-template.c $NEOTERM_PKG_SRCDIR/libvbisam/
	cp $NEOTERM_PKG_BUILDER_DIR/efgcvt-dbl-macros.h $NEOTERM_PKG_SRCDIR/libvbisam/
	autoreconf -fi
}
