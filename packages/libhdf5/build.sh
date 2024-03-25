NEOTERM_PKG_HOMEPAGE=https://portal.hdfgroup.org/display/support
NEOTERM_PKG_DESCRIPTION="Hierarchical Data Format 5 (HDF5)"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.14.3"
#NEOTERM_PKG_SRCURL=https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-${NEOTERM_PKG_VERSION:0:4}/hdf5-$NEOTERM_PKG_VERSION/src/hdf5-$NEOTERM_PKG_VERSION.tar.bz2
NEOTERM_PKG_SRCURL=https://fossies.org/linux/misc/hdf5-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=9425f224ed75d1280bb46d6f26923dd938f9040e7eaebf57e66ec7357c08f917
NEOTERM_PKG_DEPENDS="libc++, zlib"
NEOTERM_PKG_BREAKS="libhdf5-dev"
NEOTERM_PKG_REPLACES="libhdf5-dev"
NEOTERM_PKG_GROUPS="science"
NEOTERM_PKG_FORCE_CMAKE=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DHDF5_BUILD_CPP_LIB=ON
-DHDF5_ENABLE_Z_LIB_SUPPORT=ON
-C$NEOTERM_PKG_BUILDER_DIR/$NEOTERM_ARCH/TryRunResults_out.cmake
"

neoterm_step_post_get_source() {
	local d="hdf5-${NEOTERM_PKG_VERSION}"
	if [ -d "${d}" ]; then
		find "${d}" -mindepth 1 -maxdepth 1 -exec mv '{}' ./ \;
		rmdir "${d}"
	fi
}

neoterm_step_pre_configure () {
	mkdir -p $NEOTERM_PKG_BUILDDIR/src/shared/
	cp $NEOTERM_PKG_BUILDER_DIR/$NEOTERM_ARCH/{H5Tinit.c,H5lib_settings.c} $NEOTERM_PKG_BUILDDIR/src/
	cp $NEOTERM_PKG_BUILDER_DIR/$NEOTERM_ARCH/{H5Tinit.c,H5lib_settings.c} $NEOTERM_PKG_BUILDDIR/src/shared/
	touch $NEOTERM_PKG_BUILDDIR/src/gen_SRCS.stamp1 $NEOTERM_PKG_BUILDDIR/src/gen_SRCS.stamp2
	touch $NEOTERM_PKG_BUILDDIR/src/shared/shared_gen_SRCS.stamp1 $NEOTERM_PKG_BUILDDIR/src/shared/shared_gen_SRCS.stamp2
}

neoterm_step_post_configure () {
	cp $NEOTERM_PKG_BUILDER_DIR/$NEOTERM_ARCH/{H5Tinit.c,H5lib_settings.c} $NEOTERM_PKG_BUILDDIR/src/shared/
}
