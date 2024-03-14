NEOTERM_PKG_HOMEPAGE=https://djvu.sourceforge.net/
NEOTERM_PKG_DESCRIPTION="Suite to create, manipulate and view DjVu ('déjà vu') documents"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.5.28
NEOTERM_PKG_REVISION=6
NEOTERM_PKG_SRCURL=http://downloads.sourceforge.net/djvu/djvulibre-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=fcd009ea7654fde5a83600eb80757bd3a76998e47d13c66b54c8db849f8f2edc
NEOTERM_PKG_DEPENDS="libc++, libjpeg-turbo, libtiff"

neoterm_step_pre_configure() {
	NOCONFIGURE=1 ./autogen.sh

	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
