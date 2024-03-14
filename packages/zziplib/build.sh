NEOTERM_PKG_HOMEPAGE=https://zziplib.sourceforge.net/
NEOTERM_PKG_DESCRIPTION="Provides read access to zipped files in a zip-archive, using compression based on free algorithms"
NEOTERM_PKG_LICENSE="LGPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.13.74"
NEOTERM_PKG_SRCURL=https://github.com/gdraheim/zziplib/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=319093aa98d39453f3ea2486a86d8a2fab2d5632f6633a2665318723a908eecf
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_FORCE_CMAKE=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="-DZZIPTEST=off -DZZIPDOCS=off"
NEOTERM_PKG_DEPENDS="zlib"

neoterm_step_post_make_install() {
	cd $NEOTERM_PREFIX/lib
	for lib in zzip zzipfseeko zzipmmapped zzipwrap; do
		ln -sf lib${lib}-0.so lib${lib}.so
	done
}
