NEOTERM_PKG_HOMEPAGE="https://tvheadend.org/"
NEOTERM_PKG_DESCRIPTION="TV streaming server for Linux and Android supporting DVB-S, DVB-S2 and other formats."
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="Aditya Alok <alok@neoterm.org>"
NEOTERM_PKG_VERSION=4.2.8
NEOTERM_PKG_REVISION=10
NEOTERM_PKG_SRCURL="https://github.com/tvheadend/tvheadend/archive/v${NEOTERM_PKG_VERSION}.tar.gz"
NEOTERM_PKG_SHA256=1aef889373d5fad2a7bd2f139156d4d5e34a64b6d38b87b868a2df415f01f7ad
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_DEPENDS="dbus, libandroid-execinfo, libdvbcsa, libiconv, openssl, tvheadend-data, zlib"
NEOTERM_PKG_BUILD_IN_SRC=true

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--enable-android
--enable-pngquant
--enable-dvbcsa
--disable-libav
--disable-hdhomerun_static
--disable-ffmpeg_static
--disable-avahi
"

neoterm_step_pre_configure() {
	neoterm_setup_cmake

	CFLAGS=" -I$NEOTERM_PKG_BUILDDIR/src $CFLAGS $CPPFLAGS -fcommon"
	LDFLAGS+=" -landroid-execinfo"

	# Arm does not support mmx and sse2 instructions, still checks return true
	if [ "${NEOTERM_ARCH}" = "arm" ] || [ "${NEOTERM_ARCH}" = "aarch64" ]; then
		patch -p1 <"${NEOTERM_PKG_BUILDER_DIR}/disable-mmx-sse2"
	fi
}
