NEOTERM_PKG_HOMEPAGE=https://clang.llvm.org/
NEOTERM_PKG_DESCRIPTION="Modular compiler and toolchain technologies library"
NEOTERM_PKG_LICENSE="Apache-2.0, NCSA"
NEOTERM_PKG_LICENSE_FILE="llvm/LICENSE.TXT"
NEOTERM_PKG_MAINTAINER="@finagolfin"
LLVM_MAJOR_VERSION=17
NEOTERM_PKG_VERSION=${LLVM_MAJOR_VERSION}.0.6
NEOTERM_PKG_SHA256=58a8818c60e6627064f312dbf46c02d9949956558340938b71cf731ad8bc0813
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_SRCURL=https://github.com/llvm/llvm-project/releases/download/llvmorg-$NEOTERM_PKG_VERSION/llvm-project-${NEOTERM_PKG_VERSION}.src.tar.xz
NEOTERM_PKG_HOSTBUILD=true
NEOTERM_PKG_RM_AFTER_INSTALL="
bin/ld64.lld.darwin*
lib/libgomp.a
lib/libiomp5.a
share/man/man1/lit.1
"
NEOTERM_PKG_DEPENDS="libc++, libffi, libxml2, ncurses, zlib, zstd"
NEOTERM_PKG_BUILD_DEPENDS="binutils-libs"
# Replace gcc since gcc is deprecated by google on android and is not maintained upstream.
# Conflict with clang versions earlier than 3.9.1-3 since they bundled llvm.
NEOTERM_PKG_CONFLICTS="gcc, clang (<< 3.9.1-3)"
NEOTERM_PKG_BREAKS="libclang, libclang-dev, libllvm-dev"
NEOTERM_PKG_REPLACES="gcc, libclang, libclang-dev, libllvm-dev"
NEOTERM_PKG_GROUPS="base-devel"
# See http://llvm.org/docs/CMake.html:
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DANDROID_PLATFORM_LEVEL=$NEOTERM_PKG_API_LEVEL
-DPYTHON_EXECUTABLE=$(command -v python${NEOTERM_PYTHON_VERSION})
-DLLVM_ENABLE_PIC=ON
-DLLVM_ENABLE_PROJECTS=clang;clang-tools-extra;compiler-rt;lld;lldb;mlir;openmp;polly
-DLLVM_ENABLE_LIBEDIT=OFF
-DLLVM_INCLUDE_TESTS=OFF
-DCLANG_DEFAULT_CXX_STDLIB=libc++
-DCLANG_DEFAULT_LINKER=lld
-DCLANG_INCLUDE_TESTS=OFF
-DCLANG_TOOL_C_INDEX_TEST_BUILD=OFF
-DCOMPILER_RT_USE_BUILTINS_LIBRARY=ON
-DDEFAULT_SYSROOT=$(dirname $NEOTERM_PREFIX/)
-DLLVM_LINK_LLVM_DYLIB=ON
-DLLDB_ENABLE_PYTHON=ON
-DLLDB_PYTHON_RELATIVE_PATH=lib/python${NEOTERM_PYTHON_VERSION}/site-packages
-DLLDB_PYTHON_EXE_RELATIVE_PATH=bin/python${NEOTERM_PYTHON_VERSION}
-DLLDB_PYTHON_EXT_SUFFIX=.cpython-${NEOTERM_PYTHON_VERSION}.so
-DLLVM_NATIVE_TOOL_DIR=$NEOTERM_PKG_HOSTBUILD_DIR/bin
-DCROSS_TOOLCHAIN_FLAGS_LLVM_NATIVE=-DLLVM_NATIVE_TOOL_DIR=$NEOTERM_PKG_HOSTBUILD_DIR/bin
-DLIBOMP_ENABLE_SHARED=FALSE
-DOPENMP_ENABLE_LIBOMPTARGET=OFF
-DLLVM_ENABLE_SPHINX=ON
-DSPHINX_OUTPUT_MAN=ON
-DSPHINX_WARNINGS_AS_ERRORS=OFF
-DLLVM_TARGETS_TO_BUILD=all
-DLLVM_EXPERIMENTAL_TARGETS_TO_BUILD=ARC;CSKY;M68k;VE
-DPERL_EXECUTABLE=$(command -v perl)
-DLLVM_ENABLE_FFI=ON
-DLLVM_INSTALL_UTILS=ON
-DLLVM_BINUTILS_INCDIR=$NEOTERM_PREFIX/include
-DMLIR_INSTALL_AGGREGATE_OBJECTS=OFF
"

if [ x$NEOTERM_ARCH_BITS = x32 ]; then
	# Do not set _FILE_OFFSET_BITS=64
	NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" -DLLVM_FORCE_SMALLFILE_FOR_ANDROID=on"
fi

NEOTERM_PKG_FORCE_CMAKE=true
NEOTERM_PKG_HAS_DEBUG=false
# Debug build succeeds but make install with:
# cp: cannot stat '../src/projects/openmp/runtime/exports/common.min.50.ompt.optional/include/omp.h': No such file or directory
# common.min.50.ompt.optional should be common.deb.50.ompt.optional when doing debug build

neoterm_step_host_build() {
	neoterm_setup_cmake
	neoterm_setup_ninja

	cmake -G Ninja -DCMAKE_BUILD_TYPE=Release \
		-DLLVM_ENABLE_PROJECTS='clang;clang-tools-extra;lldb;mlir' $NEOTERM_PKG_SRCDIR/llvm
	ninja -j $NEOTERM_MAKE_PROCESSES clang-tblgen clang-pseudo-gen \
		clang-tidy-confusable-chars-gen lldb-tblgen llvm-tblgen mlir-tblgen mlir-linalg-ods-yaml-gen
}

neoterm_step_pre_configure() {
	# Add unknown vendor, otherwise it screws with the default LLVM triple
	# detection.
	export LLVM_DEFAULT_TARGET_TRIPLE=${CCNEOTERM_HOST_PLATFORM/-/-unknown-}
	export LLVM_TARGET_ARCH
	if [ $NEOTERM_ARCH = "arm" ]; then
		LLVM_TARGET_ARCH=ARM
	elif [ $NEOTERM_ARCH = "aarch64" ]; then
		LLVM_TARGET_ARCH=AArch64
	elif [ $NEOTERM_ARCH = "i686" ] || [ $NEOTERM_ARCH = "x86_64" ]; then
		LLVM_TARGET_ARCH=X86
	else
		neoterm_error_exit "Invalid arch: $NEOTERM_ARCH"
	fi
	# see CMakeLists.txt and tools/clang/CMakeLists.txt
	NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" -DLLVM_TARGET_ARCH=$LLVM_TARGET_ARCH"
	NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" -DLLVM_HOST_TRIPLE=$LLVM_DEFAULT_TARGET_TRIPLE"
	export NEOTERM_SRCDIR_SAVE=$NEOTERM_PKG_SRCDIR
	NEOTERM_PKG_SRCDIR=$NEOTERM_PKG_SRCDIR/llvm
}

neoterm_step_post_configure() {
	NEOTERM_PKG_SRCDIR=$NEOTERM_SRCDIR_SAVE
}

neoterm_step_post_make_install() {
	if [ "$NEOTERM_CMAKE_BUILD" = Ninja ]; then
		ninja -j $NEOTERM_MAKE_PROCESSES docs-{llvm,clang}-man
	else
		make -j $NEOTERM_MAKE_PROCESSES docs-{llvm,clang}-man
	fi

	cp docs/man/* $NEOTERM_PREFIX/share/man/man1
	cp tools/clang/docs/man/{clang,diagtool}.1 $NEOTERM_PREFIX/share/man/man1
	cd $NEOTERM_PREFIX/bin

	for tool in clang clang++ cc c++ cpp gcc g++ ${NEOTERM_HOST_PLATFORM}-{clang,clang++,gcc,g++,cpp}; do
		ln -f -s clang-${LLVM_MAJOR_VERSION} $tool
	done

	ln -f -s clang++ clang++-${LLVM_MAJOR_VERSION}

	if [ $NEOTERM_ARCH == "arm" ]; then
		# For arm we replace symlinks with the same type of
		# wrapper as the ndk uses to choose correct target
		for tool in ${NEOTERM_HOST_PLATFORM}-{clang,gcc}; do
			unlink $tool
			cat <<- EOF > $tool
			#!$NEOTERM_PREFIX/bin/bash
			if [ "\$1" != "-cc1" ]; then
				\`dirname \$0\`/clang --target=armv7a-linux-androideabi$NEOTERM_PKG_API_LEVEL "\$@"
			else
				# Target is already an argument.
				\`dirname \$0\`/clang "\$@"
			fi
			EOF
			chmod u+x $tool
		done
		for tool in ${NEOTERM_HOST_PLATFORM}-{clang++,g++}; do
			unlink $tool
			cat <<- EOF > $tool
			#!$NEOTERM_PREFIX/bin/bash
			if [ "\$1" != "-cc1" ]; then
				\`dirname \$0\`/clang++ --target=armv7a-linux-androideabi$NEOTERM_PKG_API_LEVEL "\$@"
			else
				# Target is already an argument.
				\`dirname \$0\`/clang++ "\$@"
			fi
			EOF
			chmod u+x $tool
		done
	fi
}
