NEOTERM_PKG_HOMEPAGE=https://www.openimagedenoise.org
NEOTERM_PKG_DESCRIPTION="Intel® Open Image Denoise library"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.4.3
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/OpenImageDenoise/oidn/releases/download/v$NEOTERM_PKG_VERSION/oidn-$NEOTERM_PKG_VERSION.src.tar.gz
NEOTERM_PKG_SHA256=3276e252297ebad67a999298d8f0c30cfb221e166b166ae5c955d88b94ad062a
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_DEPENDS="libc++, libllvm, libtbb"
# OIDN supports 64-bit platforms only and won't build on Linux ARM64, see
# https://github.com/OpenImageDenoise/oidn/issues/125#issuecomment-916479769
# and https://github.com/OpenImageDenoise/oidn/#prerequisites.
NEOTERM_PKG_BLACKLISTED_ARCHES="aarch64, arm, i686"

neoterm_step_pre_configure() {
	local ISPC_VERSION=1.18.0
	local ISPC_URL=https://github.com/ispc/ispc/releases/download/v$ISPC_VERSION/ispc-v$ISPC_VERSION-linux.tar.gz
	local ISPC_TARFILE=$NEOTERM_PKG_CACHEDIR/$(basename $ISPC_URL)
	local ISPC_SHA256=6c379bb97962e9de7d24fd48b3f7e647dc42be898e9d187948220268c646b692
	neoterm_download $ISPC_URL $ISPC_TARFILE $ISPC_SHA256
	if [ ! -e "$NEOTERM_PKG_CACHEDIR/.placeholder-ispc-v$ISPC_VERSION" ]; then
		rm -rf $NEOTERM_PKG_CACHEDIR/ispc-v$ISPC_VERSION-linux
		tar -xvf $ISPC_TARFILE -C $NEOTERM_PKG_CACHEDIR
		touch "$NEOTERM_PKG_CACHEDIR/.placeholder-ispc-v$ISPC_VERSION"
	fi
	export PATH="$NEOTERM_PKG_CACHEDIR/ispc-v$ISPC_VERSION-linux/bin:$PATH"
	LDFLAGS+=" -llog"
}
