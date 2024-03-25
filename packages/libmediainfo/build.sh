NEOTERM_PKG_HOMEPAGE=https://mediaarea.net/en/MediaInfo
NEOTERM_PKG_DESCRIPTION="Library for reading information from media files"
NEOTERM_PKG_LICENSE="BSD 2-Clause"
NEOTERM_PKG_LICENSE_FILE="../../../LICENSE"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="24.01"
NEOTERM_PKG_SRCURL=https://mediaarea.net/download/source/libmediainfo/${NEOTERM_PKG_VERSION}/libmediainfo_${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=a02dfc6689f485cec06fa12a3414c3c3aa2853b4dde18aeab4b54a56c8316259
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libc++, libcurl, libzen, zlib"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--enable-shared --enable-static --with-libcurl"

neoterm_step_pre_configure() {
	NEOTERM_PKG_SRCDIR="${NEOTERM_PKG_SRCDIR}/Project/GNU/Library"
	NEOTERM_PKG_BUILDDIR="${NEOTERM_PKG_SRCDIR}"
	cd "${NEOTERM_PKG_SRCDIR}"
	./autogen.sh
	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
