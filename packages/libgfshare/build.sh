NEOTERM_PKG_HOMEPAGE=http://www.digital-scurf.org/software/libgfshare
NEOTERM_PKG_DESCRIPTION="Utilities for multi-way secret-sharing"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.0.0
NEOTERM_PKG_REVISION=7
NEOTERM_PKG_SRCURL=http://www.digital-scurf.org/files/libgfshare/libgfshare-$NEOTERM_PKG_VERSION.tar.bz2
NEOTERM_PKG_SHA256=86f602860133c828356b7cf7b8c319ba9b27adf70a624fe32275ba1ed268331f
NEOTERM_PKG_BREAKS="libgfshare-dev"
NEOTERM_PKG_REPLACES="libgfshare-dev"

neoterm_step_post_configure() {
	gcc -DHAVE_CONFIG_H \
		-I. \
		-I"$NEOTERM_PKG_SRCDIR" \
		-I"$NEOTERM_PKG_SRCDIR"/include \
		"$NEOTERM_PKG_SRCDIR"/src/gfshare_maketable.c \
		-o gfshare_maketable
	touch -d "next hour" gfshare_maketable
}
