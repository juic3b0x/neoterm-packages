NEOTERM_PKG_HOMEPAGE=https://code.videolan.org/videolan/dav1d/
NEOTERM_PKG_DESCRIPTION="AV1 cross-platform decoder focused on speed and correctness"
NEOTERM_PKG_LICENSE="BSD 2-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.4.0"
NEOTERM_PKG_SRCURL=https://code.videolan.org/videolan/dav1d/-/archive/${NEOTERM_PKG_VERSION}/dav1d-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=7661648c95755db3d61857b3fdc427fa6d3271a573e84fd11c235441965e9397
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Denable_tools=false
-Denable_tests=false
"

neoterm_step_pre_configure() {
	if [ "$NEOTERM_ARCH" = "i686" ]; then
		# Avoid text relocations.
		NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" -Denable_asm=false"
	fi
}
