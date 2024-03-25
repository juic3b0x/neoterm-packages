NEOTERM_PKG_HOMEPAGE=https://flang.llvm.org/
NEOTERM_PKG_DESCRIPTION="LLVM's Fortran frontend"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_LICENSE_FILE="flang/LICENSE.TXT"
NEOTERM_PKG_MAINTAINER="@neoterm"
LLVM_MAJOR_VERSION=17
NEOTERM_PKG_VERSION=${LLVM_MAJOR_VERSION}.0.6
NEOTERM_PKG_SRCURL=https://github.com/llvm/llvm-project/releases/download/llvmorg-$NEOTERM_PKG_VERSION/llvm-project-$NEOTERM_PKG_VERSION.src.tar.xz
NEOTERM_PKG_SHA256=58a8818c60e6627064f312dbf46c02d9949956558340938b71cf731ad8bc0813
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_HOSTBUILD=true
# `flang-new` should be rebuilt when libllvm bumps version.
# See https://github.com/neoterm/neoterm-packages/issues/19362
NEOTERM_PKG_DEPENDS="libc++, libllvm (= $NEOTERM_PKG_VERSION), clang (= $NEOTERM_PKG_VERSION), lld (= $NEOTERM_PKG_VERSION), mlir (= $NEOTERM_PKG_VERSION)"
NEOTERM_PKG_BUILD_DEPENDS="libllvm-static"

# Upstream doesn't support 32-bit arches well. See https://github.com/llvm/llvm-project/issues/57621.
NEOTERM_PKG_BLACKLISTED_ARCHES="arm, i686"

# See http://llvm.org/docs/CMake.html:
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_BUILD_TYPE=MinSizeRel
-DLLVM_ENABLE_PIC=ON
-DDEFAULT_SYSROOT=$(dirname $NEOTERM_PREFIX)
-DLLVM_LINK_LLVM_DYLIB=ON
-DLLVM_TARGETS_TO_BUILD=all
-DLLVM_ENABLE_FFI=ON
-DFLANG_DEFAULT_LINKER=lld
-DMLIR_INSTALL_AGGREGATE_OBJECTS=OFF
-DFLANG_ENABLE_WERROR=On
-DFLANG_INCLUDE_TESTS=OFF
-DLLVM_ENABLE_ASSERTIONS=On
-DLLVM_LIT_ARGS=-v
-DLLVM_DIR=$NEOTERM_PREFIX/lib/cmake/llvm
-DCLANG_DIR=$NEOTERM_PREFIX/lib/cmake/clang
-DMLIR_DIR=$NEOTERM_PREFIX/lib/cmake/mlir
-DMLIR_TABLEGEN_EXE=$NEOTERM_PKG_HOSTBUILD_DIR/bin/mlir-tblgen
-DLLVM_NATIVE_TOOL_DIR=$NEOTERM_PKG_HOSTBUILD_DIR/bin
-DCROSS_TOOLCHAIN_FLAGS_LLVM_NATIVE=-DLLVM_NATIVE_TOOL_DIR=$NEOTERM_PKG_HOSTBUILD_DIR/bin
"

if [ $NEOTERM_ARCH_BITS = 32 ]; then
	# Do not set _FILE_OFFSET_BITS=64
	NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" -DLLVM_FORCE_SMALLFILE_FOR_ANDROID=on"
fi

NEOTERM_PKG_FORCE_CMAKE=true
NEOTERM_PKG_HAS_DEBUG=false
NEOTERM_PKG_NO_STATICSPLIT=true

neoterm_step_host_build() {
	neoterm_setup_cmake
	neoterm_setup_ninja

	cmake -G Ninja "-DCMAKE_BUILD_TYPE=Release" \
				   "-DLLVM_ENABLE_PROJECTS=clang;mlir" \
				   $NEOTERM_PKG_SRCDIR/llvm
	ninja -j $NEOTERM_MAKE_PROCESSES clang-tblgen mlir-tblgen
}

neoterm_step_pre_configure() {
	export PATH="$NEOTERM_PKG_HOSTBUILD_DIR/bin:$PATH"
	# Add unknown vendor, otherwise it screws with the default LLVM triple detection.
	export LLVM_DEFAULT_TARGET_TRIPLE=${CCNEOTERM_HOST_PLATFORM/-/-unknown-}
	# see CMakeLists.txt and tools/clang/CMakeLists.txt
	NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" -DLLVM_HOST_TRIPLE=$LLVM_DEFAULT_TARGET_TRIPLE"
	NEOTERM_SRCDIR_SAVE=$NEOTERM_PKG_SRCDIR
	NEOTERM_PKG_SRCDIR=$NEOTERM_PKG_SRCDIR/flang
	# Avoid the possible OOM
	NEOTERM_MAKE_PROCESSES=1
}

neoterm_step_post_configure() {
	NEOTERM_PKG_SRCDIR=$NEOTERM_SRCDIR_SAVE
	unset NEOTERM_SRCDIR_SAVE
}

neoterm_step_post_make_install() {
	# Copy module source files
	mkdir -p $NEOTERM_PREFIX/opt/flang/{include,module}
	cp -f $NEOTERM_PKG_SRCDIR/flang/module/* $NEOTERM_PREFIX/opt/flang/module/
	ln -sf $NEOTERM_PREFIX/include/flang $NEOTERM_PREFIX/opt/flang/include/
}

neoterm_step_create_debscripts() {
	sed -e "s|@NEOTERM_PREFIX@|$NEOTERM_PREFIX|g" \
		"$NEOTERM_PKG_BUILDER_DIR/postinst.sh.in" > ./postinst
	chmod +x ./postinst

	sed -e "s|@NEOTERM_PREFIX@|$NEOTERM_PREFIX|g" \
		"$NEOTERM_PKG_BUILDER_DIR/prerm.sh.in" > ./prerm
	chmod +x ./prerm
}
