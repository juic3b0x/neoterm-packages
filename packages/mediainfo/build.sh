NEOTERM_PKG_HOMEPAGE=https://mediaarea.net/en/MediaInfo
NEOTERM_PKG_DESCRIPTION="Command-line utility for reading information from media files"
NEOTERM_PKG_LICENSE="BSD 2-Clause"
NEOTERM_PKG_LICENSE_FILE="../../../LICENSE"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="24.01.1"
NEOTERM_PKG_SRCURL=https://mediaarea.net/download/source/mediainfo/${NEOTERM_PKG_VERSION}/mediainfo_${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=32ea646d5c86c63d54418d10b2736260ab43e4b727f81e8dd5ecf5e9b5e3fd34
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libandroid-support, libc++, libmediainfo, libzen"

neoterm_step_pre_configure() {
	NEOTERM_PKG_SRCDIR="${NEOTERM_PKG_SRCDIR}/Project/GNU/CLI"
	NEOTERM_PKG_BUILDDIR="${NEOTERM_PKG_SRCDIR}"
	cd "${NEOTERM_PKG_SRCDIR}"
	./autogen.sh
}
