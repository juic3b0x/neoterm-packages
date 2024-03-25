NEOTERM_PKG_HOMEPAGE=https://scripts.sil.org/teckitdownloads
NEOTERM_PKG_DESCRIPTION="TECkit is a library for encoding conversion"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="Henrik Grimler @Grimler91"
NEOTERM_PKG_VERSION="2.5.12"
NEOTERM_PKG_SRCURL=https://github.com/silnrsi/teckit/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=0ede00cc473fada257a440f590c754af3608076d3d986647af9653ace119b9d5
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libc++, zlib"
NEOTERM_PKG_BREAKS="teckit-dev"
NEOTERM_PKG_REPLACES="teckit-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_lib_expat_XML_ExpatVersion=no"

neoterm_step_pre_configure() {
	./autogen.sh

	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
