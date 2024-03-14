NEOTERM_PKG_HOMEPAGE=https://github.com/ldc-developers/ldc
NEOTERM_PKG_DESCRIPTION="D programming language compiler, built with LLVM"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=(1.30.0)
NEOTERM_PKG_VERSION+=(14.0.3)  # LLVM version
NEOTERM_PKG_VERSION+=(2.100.1) # TOOLS version
NEOTERM_PKG_VERSION+=(1.30.0)  # DUB version

NEOTERM_PKG_SRCURL=(https://github.com/ldc-developers/ldc/releases/download/v${NEOTERM_PKG_VERSION}/ldc-${NEOTERM_PKG_VERSION}-src.tar.gz
		   https://github.com/ldc-developers/llvm-project/releases/download/ldc-v${NEOTERM_PKG_VERSION[1]}/llvm-${NEOTERM_PKG_VERSION[1]}.src.tar.xz
		   https://github.com/llvm/llvm-project/releases/download/llvmorg-${NEOTERM_PKG_VERSION[1]}/libunwind-${NEOTERM_PKG_VERSION[1]}.src.tar.xz
		   https://github.com/dlang/tools/archive/v${NEOTERM_PKG_VERSION[2]}.tar.gz
		   https://github.com/dlang/dub/archive/v${NEOTERM_PKG_VERSION[3]}.tar.gz
		   https://github.com/ldc-developers/ldc/releases/download/v${NEOTERM_PKG_VERSION}/ldc2-${NEOTERM_PKG_VERSION}-linux-x86_64.tar.xz)
NEOTERM_PKG_SHA256=(fdbb376f08242d917922a6a22a773980217fafa310046fc5d6459490af23dacd
		   9638d8d0b6a43d9cdc53699bec19e6bc9bef98f5950b99e6b8c1ec373aee4fa7
		   301137841d1e3401f59b3828d2a9ac86a1b826b89265d55541a2fd6ca2a595eb
		   54bde9a979d70952690a517f90de8d76631fa9a2f7252af7278dafbcaaa42d54
		   840cd65bf5f0dd06ca688f63b94d71fccd92b526bbf1d3892fe5535b1e85c10e
		   5784d4cc47d0845af0897d3b7473a08dd0281a4cdabac0a486740840d014fde1)
NEOTERM_PKG_AUTO_UPDATE=false
# dub dlopen()s libcurl.so:
NEOTERM_PKG_DEPENDS="binutils-bin, binutils-is-llvm | binutils, clang, libc++, libcurl, zlib"
NEOTERM_PKG_BUILD_DEPENDS="binutils-cross"
NEOTERM_PKG_NO_STATICSPLIT=true
NEOTERM_PKG_HOSTBUILD=true
NEOTERM_PKG_FORCE_CMAKE=true
#These CMake args are only used to configure a patched LLVM
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DLLVM_ENABLE_PLUGINS=OFF
-DLLVM_BUILD_TOOLS=OFF
-DLLVM_BUILD_UTILS=OFF
-DLLVM_ENABLE_UNWIND_TABLES=OFF
-DLLVM_ENABLE_TERMINFO=OFF
-DLLVM_ENABLE_LIBEDIT=OFF
-DLLVM_INCLUDE_BENCHMARKS=OFF
-DCOMPILER_RT_INCLUDE_TESTS=OFF
-DLLVM_INCLUDE_TESTS=OFF
-DLLVM_TABLEGEN=$NEOTERM_PKG_HOSTBUILD_DIR/bin/llvm-tblgen
-DLLVM_CONFIG_PATH=$NEOTERM_PKG_HOSTBUILD_DIR/bin/llvm-config
-DPYTHON_EXECUTABLE=$(command -v python3)
-DLLVM_TARGETS_TO_BUILD='AArch64;ARM;WebAssembly;X86'
"

neoterm_step_post_get_source() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $NEOTERM_PREFIX.
	if $NEOTERM_ON_DEVICE_BUILD; then
		neoterm_error_exit "Package '$NEOTERM_PKG_NAME' is not safe for on-device builds."
	fi

	mv llvm-${NEOTERM_PKG_VERSION[1]}.src llvm
	mv libunwind-${NEOTERM_PKG_VERSION[1]}.src libunwind
	mv tools-${NEOTERM_PKG_VERSION[2]} dlang-tools
	mv dub-${NEOTERM_PKG_VERSION[3]} dub

	# Exclude MLIR
	rm -Rf llvm/projects/mlir

	LLVM_TRIPLE=${NEOTERM_HOST_PLATFORM/-/--}
	if [ $NEOTERM_ARCH = arm ]; then LLVM_TRIPLE=${LLVM_TRIPLE/arm-/armv7a-}; fi
}

neoterm_step_host_build() {
	neoterm_setup_cmake
	neoterm_setup_ninja

	# Build native llvm-tblgen, a prerequisite for cross-compiling LLVM
	cmake -GNinja $NEOTERM_PKG_SRCDIR/llvm \
		-DCMAKE_BUILD_TYPE=Release \
		-DLLVM_BUILD_TOOLS=OFF \
		-DLLVM_BUILD_UTILS=OFF \
		-DLLVM_INCLUDE_BENCHMARKS=OFF \
		-DCOMPILER_RT_INCLUDE_TESTS=OFF \
		-DLLVM_INCLUDE_TESTS=OFF
	ninja -j $NEOTERM_MAKE_PROCESSES llvm-tblgen
}

# Just before CMake invokation for LLVM:
neoterm_step_pre_configure() {
	PATH=$NEOTERM_PREFIX/opt/binutils/cross/$NEOTERM_HOST_PLATFORM/bin:$PATH

	LLVM_INSTALL_DIR=$NEOTERM_PKG_BUILDDIR/llvm-install
	NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" -DCMAKE_INSTALL_PREFIX=$LLVM_INSTALL_DIR"

	if [ "$NEOTERM_ARCH" == "arm" ]; then
		# [...]/ldc/src/llvm/projects/compiler-rt/lib/builtins/clear_cache.c:85:20:
		# error: write to reserved register 'R7'
		#   __asm __volatile("svc 0x0"
		#                    ^
		CFLAGS="${CFLAGS//-mthumb/}"
	fi
	LDFLAGS=" -L$NEOTERM_PKG_BUILDDIR/llvm/lib $LDFLAGS -lc++_shared"

	# Don't build compiler-rt sanitizers:
	# * 64-bit targets: libclang_rt.hwasan-*-android.so fails to link
	# * 32-bit targets: compile errors for interception library
	NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" -DCOMPILER_RT_BUILD_SANITIZERS=OFF -DCOMPILER_RT_BUILD_MEMPROF=OFF"

	local LLVM_TARGET_ARCH
	if [ $NEOTERM_ARCH = "arm" ]; then
		LLVM_TARGET_ARCH=ARM
	elif [ $NEOTERM_ARCH = "aarch64" ]; then
		LLVM_TARGET_ARCH=AArch64
	elif [ $NEOTERM_ARCH = "i686" ]; then
		LLVM_TARGET_ARCH=X86
	elif [ $NEOTERM_ARCH = "x86_64" ]; then
		LLVM_TARGET_ARCH=X86
	else
		neoterm_error_exit "Invalid arch: $NEOTERM_ARCH"
	fi
	NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" -DLLVM_DEFAULT_TARGET_TRIPLE=${LLVM_TRIPLE}"
	NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" -DLLVM_TARGET_ARCH=${LLVM_TARGET_ARCH}"

	# CPPFLAGS adds the system llvm to the include path, which causes
	# conflicts with the local patched llvm when compiling ldc
	CPPFLAGS=""

	OLD_NEOTERM_PKG_SRCDIR=$NEOTERM_PKG_SRCDIR
	NEOTERM_PKG_SRCDIR=$NEOTERM_PKG_SRCDIR/llvm

	OLD_NEOTERM_PKG_BUILDDIR=$NEOTERM_PKG_BUILDDIR
	NEOTERM_PKG_BUILDDIR=$NEOTERM_PKG_BUILDDIR/llvm
	mkdir "$NEOTERM_PKG_BUILDDIR"
}

# CMake for LLVM has been run:
neoterm_step_post_configure() {
	# Cross-compile & install LLVM
	cd "$NEOTERM_PKG_BUILDDIR"
	if test -f build.ninja; then
		ninja -j $NEOTERM_MAKE_PROCESSES install
	fi

	# Invoke CMake for LDC:

	NEOTERM_PKG_SRCDIR=$OLD_NEOTERM_PKG_SRCDIR
	NEOTERM_PKG_BUILDDIR=$OLD_NEOTERM_PKG_BUILDDIR
	cd "$NEOTERM_PKG_BUILDDIR"

	# Replace non-native llvm-config executable with bash script,
	# as it is going to be invoked during LDC CMake config.
	sed $NEOTERM_PKG_SRCDIR/.github/actions/3-build-cross/android-llvm-config.in \
		-e "s|@LLVM_VERSION@|${NEOTERM_PKG_VERSION[1]}|g" \
		-e "s|@LLVM_INSTALL_DIR@|$LLVM_INSTALL_DIR|g" \
		-e "s|@NEOTERM_PKG_SRCDIR@|$NEOTERM_PKG_SRCDIR/llvm|g" \
		-e "s|@LLVM_DEFAULT_TARGET_TRIPLE@|$LLVM_TRIPLE|g" \
		-e "s|@LLVM_TARGETS@|AArch64 ARM X86 WebAssembly|g" > $LLVM_INSTALL_DIR/bin/llvm-config
	chmod 755 $LLVM_INSTALL_DIR/bin/llvm-config

	LDC_FLAGS="-mtriple=$LLVM_TRIPLE"

	LDC_PATH=$NEOTERM_PKG_SRCDIR/ldc2-$NEOTERM_PKG_VERSION-linux-x86_64
	DMD=$LDC_PATH/bin/ldmd2

	NEOTERM_PKG_EXTRA_CONFIGURE_ARGS=" -DLLVM_ROOT_DIR=$LLVM_INSTALL_DIR \
		-DD_COMPILER=$DMD \
		-DCMAKE_INSTALL_PREFIX=$NEOTERM_PREFIX \
		-DLDC_WITH_LLD=OFF \
		-DLDC_INSTALL_LLVM_RUNTIME_LIBS_OS=android \
		-DLDC_INSTALL_LLVM_RUNTIME_LIBS_ARCH=$NEOTERM_ARCH-android \
		-DD_LINKER_ARGS='-fuse-ld=bfd;-Lldc-build-runtime.tmp/lib;-lphobos2-ldc;-ldruntime-ldc;-Wl,--gc-sections'"

	neoterm_step_configure_cmake
}

neoterm_step_make() {
	# Cross-compile the runtime libraries
	$LDC_PATH/bin/ldc-build-runtime --ninja -j $NEOTERM_MAKE_PROCESSES \
		--dFlags="-fvisibility=hidden;$LDC_FLAGS" \
		--cFlags="-I$NEOTERM_PREFIX/include" \
		--targetSystem="Android;Linux;UNIX" \
		--ldcSrcDir="$NEOTERM_PKG_SRCDIR"

	# Set up host ldmd2 for cross-compilation
	export DFLAGS="${LDC_FLAGS//;/ }"

	# Cross-compile LDC executables (linked against runtime libs above)
	if test -f build.ninja; then
		ninja -j $NEOTERM_MAKE_PROCESSES ldc2 ldmd2 ldc-build-runtime ldc-profdata ldc-prune-cache
	fi
	echo ".: LDC built successfully."

	# Cross-compile dlang tools and dub:

	# Extend DFLAGS for cross-linking with host ldmd2
	export DFLAGS="$DFLAGS -linker=bfd -L-L$NEOTERM_PKG_BUILDDIR/ldc-build-runtime.tmp/lib"
	if [ $NEOTERM_ARCH = arm ]; then export DFLAGS="$DFLAGS -L--fix-cortex-a8"; fi

	# https://github.com/neoterm/neoterm-packages/issues/7188
	DFLAGS+=" -L-rpath=$NEOTERM_PREFIX/lib"

	cd  $NEOTERM_PKG_SRCDIR/dlang-tools
	$DMD -w -de -dip1000 rdmd.d -of=$NEOTERM_PKG_BUILDDIR/bin/rdmd
	$DMD -w -de -dip1000 ddemangle.d -of=$NEOTERM_PKG_BUILDDIR/bin/ddemangle
	$DMD -w -de -dip1000 DustMite/dustmite.d DustMite/splitter.d DustMite/polyhash.d -of=$NEOTERM_PKG_BUILDDIR/bin/dustmite
	echo ".: dlang tools built successfully."

	cd $NEOTERM_PKG_SRCDIR/dub
	# Note: cannot link a native build.d tool, so build manually:
	$DMD -of=$NEOTERM_PKG_BUILDDIR/bin/dub -Isource -version=DubUseCurl -version=DubApplication -O -w -linkonce-templates @build-files.txt
	echo ".: dub built successfully."
}

neoterm_step_make_install() {
	cp bin/{ddemangle,dub,dustmite,ldc-build-runtime,ldc-profdata,ldc-prune-cache,ldc2,ldmd2,rdmd} $NEOTERM_PREFIX/bin
	cp $NEOTERM_PKG_BUILDDIR/ldc-build-runtime.tmp/lib/*.a $NEOTERM_PREFIX/lib
	cp lib/libldc_rt.* $NEOTERM_PREFIX/lib || true
	sed "s|$NEOTERM_PREFIX/|%%ldcbinarypath%%/../|g" bin/ldc2_install.conf > $NEOTERM_PREFIX/etc/ldc2.conf

	rm -Rf $NEOTERM_PREFIX/include/d
	mkdir $NEOTERM_PREFIX/include/d
	cp -r $NEOTERM_PKG_SRCDIR/runtime/druntime/src/{core,etc,ldc,object.d} $NEOTERM_PREFIX/include/d
	cp $LDC_PATH/import/ldc/gccbuiltins_{aarch64,arm,x86}.di $NEOTERM_PREFIX/include/d/ldc
	cp -r $NEOTERM_PKG_SRCDIR/runtime/phobos/etc/c $NEOTERM_PREFIX/include/d/etc
	rm -Rf $NEOTERM_PREFIX/include/d/etc/c/zlib
	cp -r $NEOTERM_PKG_SRCDIR/runtime/phobos/std $NEOTERM_PREFIX/include/d

	rm -Rf $NEOTERM_PREFIX/share/ldc
	mkdir $NEOTERM_PREFIX/share/ldc
	cp -r $NEOTERM_PKG_SRCDIR/{LICENSE,README,packaging/bash_completion.d} $NEOTERM_PREFIX/share/ldc
}
