NEOTERM_PKG_HOMEPAGE=https://github.com/DrTimothyAldenDavis/SuiteSparse
NEOTERM_PKG_DESCRIPTION="A Suite of Sparse matrix packages."
NEOTERM_PKG_GROUPS="science"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="7.6.1"
NEOTERM_PKG_SRCURL=https://github.com/DrTimothyAldenDavis/SuiteSparse/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=ab1992802723b09aca3cbb0f4dc9b2415a781b9ad984ed934c7d8a0dcc31bc42
NEOTERM_PKG_DEPENDS="libandroid-complex-math, libgmp, libmpfr, libopenblas"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_FORCE_CMAKE=true
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DBLA_VENDOR=OpenBLAS
-DALLOW_64BIT_BLAS=OFF
-DGRAPHBLAS_CROSS_TOOLCHAIN_FLAGS_NATIVE=\"-DCMAKE_TOOLCHAIN_FILE=$NEOTERM_PKG_BUILDER_DIR/graphblas-host-toolchain.cmake\"
"
NEOTERM_PKG_BLACKLISTED_ARCHES="arm, i686"

neoterm_step_configure() {
	neoterm_setup_cmake
	neoterm_setup_ninja
	neoterm_setup_flang

	LDFLAGS+=" -landroid-complex-math -lm"
}

neoterm_step_make() {
	# Follow neoterm_step_configure_cmake
	MAKE_PROGRAM_PATH=$(command -v make)
	BUILD_TYPE=Release
	test "$NEOTERM_DEBUG_BUILD" == "true" && BUILD_TYPE=Debug
	CMAKE_PROC=$NEOTERM_ARCH
	test $CMAKE_PROC == "arm" && CMAKE_PROC='armv7-a'

	local CMAKE_OPTIONS=
	if [ "$NEOTERM_ON_DEVICE_BUILD" = "false" ]; then
		CXXFLAGS+=" --target=$CCNEOTERM_HOST_PLATFORM"
		CFLAGS+=" --target=$CCNEOTERM_HOST_PLATFORM"
		LDFLAGS+=" --target=$CCNEOTERM_HOST_PLATFORM"

		CMAKE_OPTIONS+=" -DCMAKE_CROSSCOMPILING=True"
		CMAKE_OPTIONS+=" -DCMAKE_LINKER=\"$NEOTERM_STANDALONE_TOOLCHAIN/bin/$LD $LDFLAGS\""
		CMAKE_OPTIONS+=" -DCMAKE_SYSTEM_NAME=Android"
		CMAKE_OPTIONS+=" -DCMAKE_SYSTEM_VERSION=$NEOTERM_PKG_API_LEVEL"
		CMAKE_OPTIONS+=" -DCMAKE_SYSTEM_PROCESSOR=$CMAKE_PROC"
		CMAKE_OPTIONS+=" -DCMAKE_ANDROID_STANDALONE_TOOLCHAIN=$NEOTERM_STANDALONE_TOOLCHAIN"
	else
		CMAKE_OPTIONS+=" -DCMAKE_LINKER=\"$(command -v $LD) $LDFLAGS\""
	fi

	CMAKE_OPTIONS+=" -DCMAKE_AR=\"$(command -v $AR)\""
	CMAKE_OPTIONS+=" -DCMAKE_UNAME=\"$(command -v uname)\""
	CMAKE_OPTIONS+=" -DCMAKE_RANLIB=\"$(command -v $RANLIB)\""
	CMAKE_OPTIONS+=" -DCMAKE_STRIP=\"$(command -v $STRIP)\""
	CMAKE_OPTIONS+=" -DCMAKE_BUILD_TYPE=$BUILD_TYPE"
	CMAKE_OPTIONS+=" -DCMAKE_C_FLAGS=\"$CFLAGS $CPPFLAGS\""
	CMAKE_OPTIONS+=" -DCMAKE_CXX_FLAGS=\"$CXXFLAGS $CPPFLAGS\""
	CMAKE_OPTIONS+=" -DCMAKE_FIND_ROOT_PATH=$NEOTERM_PREFIX"
	CMAKE_OPTIONS+=" -DCMAKE_FIND_ROOT_PATH_MODE_PROGRAM=NEVER"
	CMAKE_OPTIONS+=" -DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=NEVER"
	CMAKE_OPTIONS+=" -DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY=NEVER"
	CMAKE_OPTIONS+=" -DCMAKE_INSTALL_PREFIX=$NEOTERM_PREFIX"
	CMAKE_OPTIONS+=" -DCMAKE_INSTALL_LIBDIR=$NEOTERM_PREFIX/lib"
	CMAKE_OPTIONS+=" -DCMAKE_MAKE_PROGRAM=$MAKE_PROGRAM_PATH"
	CMAKE_OPTIONS+=" -DCMAKE_SKIP_INSTALL_RPATH=ON"
	CMAKE_OPTIONS+=" -DCMAKE_USE_SYSTEM_LIBRARIES=True"
	CMAKE_OPTIONS+=" -DDOXYGEN_EXECUTABLE="
	CMAKE_OPTIONS+=" -DBUILD_TESTING=OFF"
	CMAKE_OPTIONS+=" $(echo $NEOTERM_PKG_EXTRA_CONFIGURE_ARGS)"

	make -j $NEOTERM_MAKE_PROCESSES \
		CMAKE_OPTIONS="$CMAKE_OPTIONS" JOBS=$NEOTERM_MAKE_PROCESSES
}

neoterm_step_make_install() {
	make install INSTALL=$NEOTERM_PREFIX
}

neoterm_step_post_massage() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION_GUARD_FILES="
lib/libamd.so.3
lib/libbtf.so.2
lib/libcamd.so.3
lib/libccolamd.so.3
lib/libcholmod.so.5
lib/libcolamd.so.3
lib/libcxsparse.so.4
lib/libgraphblas.so.9
lib/libklu.so.2
lib/libklu_cholmod.so.2
lib/liblagraph.so.1
lib/liblagraphx.so.1
lib/libldl.so.3
lib/libparu.so.0
lib/librbio.so.4
lib/libspex.so.2
lib/libspqr.so.4
lib/libsuitesparse_mongoose.so.3
lib/libsuitesparseconfig.so.7
lib/libumfpack.so.6
"
	local f
	for f in ${_SOVERSION_GUARD_FILES}; do
		if [ ! -e "${f}" ]; then
			neoterm_error_exit "SOVERSION guard check failed."
		fi
	done
}
