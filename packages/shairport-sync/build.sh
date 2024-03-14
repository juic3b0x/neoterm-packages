NEOTERM_PKG_HOMEPAGE=https://github.com/mikebrady/shairport-sync
NEOTERM_PKG_DESCRIPTION="An AirPlay audio player"
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="LICENSES"
NEOTERM_PKG_MAINTAINER="@neoterm"
# Cannot simply be updated to a newer version due to `pthread_cancel` being used
NEOTERM_PKG_VERSION=3.1.2
NEOTERM_PKG_REVISION=6
NEOTERM_PKG_SRCURL=https://github.com/mikebrady/shairport-sync/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=8c13f7ebbd417e8cab07ea9f74392ced0f54315d8697d4513580f472859a9c65
NEOTERM_PKG_DEPENDS="libconfig, libdaemon, libpopt, libsoxr, openssl, pulseaudio"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--with-pa
--with-soxr
--with-ssl=openssl
"

neoterm_step_pre_configure() {
	autoreconf -fi

	CFLAGS+=" -fcommon"
}
