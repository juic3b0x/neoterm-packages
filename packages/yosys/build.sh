NEOTERM_PKG_HOMEPAGE=https://yosyshq.net/yosys/
NEOTERM_PKG_DESCRIPTION="A framework for RTL synthesis tools"
NEOTERM_PKG_LICENSE="ISC"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.38"
NEOTERM_PKG_SRCURL=https://github.com/YosysHQ/yosys/archive/refs/tags/yosys-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=5f3d7bb12c5371db00586700a658a9196008a9457839f046403a660fe0c7a1df
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+"
NEOTERM_PKG_DEPENDS="graphviz, libandroid-glob, libandroid-spawn, libc++, libffi, readline, tcl, zlib"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="PREFIX=$NEOTERM_PREFIX"

neoterm_step_pre_configure() {
	LDFLAGS+=" -landroid-glob -landroid-spawn"
}
