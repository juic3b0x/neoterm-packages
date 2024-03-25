NEOTERM_PKG_HOMEPAGE=https://github.com/Netflix/vmaf
NEOTERM_PKG_DESCRIPTION="A perceptual video quality assessment algorithm developed by Netflix"
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="../LICENSE"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="3.0.0"
NEOTERM_PKG_SRCURL=https://github.com/Netflix/vmaf/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=7178c4833639e6b989ecae73131d02f70735fdb3fc2c7d84bc36c9c3461d93b1
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libc++"

neoterm_step_pre_configure() {
	NEOTERM_PKG_SRCDIR=$NEOTERM_PKG_SRCDIR/libvmaf
}
