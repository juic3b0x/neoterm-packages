NEOTERM_PKG_HOMEPAGE=https://github.com/sabnzbd/sabctools
NEOTERM_PKG_DESCRIPTION="C implementations of functions for use within SABnzbd"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="8.1.0"
NEOTERM_PKG_SRCURL=https://github.com/sabnzbd/sabctools/releases/download/v${NEOTERM_PKG_VERSION}/sabctools-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=29a7e3e6fb3a55a484948a64e05eb0feae55a9f6aec36d212dfb8249c8549ed8
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libc++, python"
NEOTERM_PKG_BUILD_DEPENDS="libcpufeatures"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_PYTHON_COMMON_DEPS="wheel"

neoterm_step_pre_configure() {
	export CXXFLAGS+=" -fPIC -I$NEOTERM_PREFIX/include/ndk_compat"
	export CFLAGS+=" -I$NEOTERM_PREFIX/include/ndk_compat"
	export LDFLAGS+=" -l:libndk_compat.a"
}
