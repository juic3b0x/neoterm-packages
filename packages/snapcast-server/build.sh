NEOTERM_PKG_HOMEPAGE=https://github.com/badaix/snapcast
NEOTERM_PKG_DESCRIPTION="A multiroom client-server audio player (server)"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.27.0
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://github.com/badaix/snapcast/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=c662c6eafbaa42a4797a4ed6ba4a7602332abf99f6ba6ea88ff8ae59978a86ba
NEOTERM_PKG_DEPENDS="libc++, libexpat, libflac, libopus, libsoxr, libvorbis"
NEOTERM_PKG_BUILD_DEPENDS="boost, boost-headers"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DANDROID_NO_NEOTERM=OFF
-DBUILD_TESTS=OFF
-DBoost_INCLUDE_DIR=$NEOTERM_PREFIX/include
"
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_post_get_source() {
	# Future-proof way of pretending not to be Android.
	find . -name CMakeLists.txt | xargs -n 1 \
		sed -i -E 's/if\s*\((.*\s|)ANDROID/\0_NO_NEOTERM/g'
}

neoterm_step_pre_configure() {
	LDFLAGS+=" -llog"
}
