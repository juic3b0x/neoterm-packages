## * Requires pulseaudio build and source directory.
## * Uses scons build system which is not good at cross-compiling.

NEOTERM_PKG_HOMEPAGE=https://roc-project.github.io
NEOTERM_PKG_DESCRIPTION="Roc real-time streaming over the network"
NEOTERM_PKG_LICENSE="LGPL-2.0, MPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.1.1
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://github.com/roc-project/roc/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=2aa63061b586a5f16cfcb0bfe304015a6effdcb373513cb62e76283bde7dd104
NEOTERM_PKG_DEPENDS="libltdl, libopenfec, libuv, pulseaudio"
NEOTERM_PKG_BREAKS="roc-dev"
NEOTERM_PKG_REPLACES="roc-dev"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	SCONS_CONFIGURE_ARGS=""
	SCONS_CONFIGURE_ARGS+=" --prefix=$NEOTERM_PREFIX"
	SCONS_CONFIGURE_ARGS+=" --host=$NEOTERM_HOST_PLATFORM"
	SCONS_CONFIGURE_ARGS+=" --compiler=clang"
	SCONS_CONFIGURE_ARGS+=" --disable-tools"
	SCONS_CONFIGURE_ARGS+=" --disable-tests"
	SCONS_CONFIGURE_ARGS+=" --disable-examples"
	SCONS_CONFIGURE_ARGS+=" --disable-doc"
	SCONS_CONFIGURE_ARGS+=" --disable-sox"
	#SCONS_CONFIGURE_ARGS+=" --disable-openfec"
	SCONS_CONFIGURE_ARGS+=" --enable-pulseaudio-modules"
	SCONS_CONFIGURE_ARGS+=" --with-openfec-includes=$NEOTERM_PREFIX/include/openfec"
	SCONS_CONFIGURE_ARGS+=" --with-pulseaudio=$NEOTERM_TOPDIR/pulseaudio/src"
	SCONS_CONFIGURE_ARGS+=" --with-pulseaudio-build-dir=$NEOTERM_TOPDIR/pulseaudio/build"

	scons $SCONS_CONFIGURE_ARGS
}

neoterm_step_make_install() {
	scons $SCONS_CONFIGURE_ARGS install
}
