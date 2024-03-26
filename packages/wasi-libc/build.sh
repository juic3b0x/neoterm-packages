NEOTERM_PKG_HOMEPAGE=https://wasi.dev/
NEOTERM_PKG_DESCRIPTION="Libc for WebAssembly programs built on top of WASI system calls"
NEOTERM_PKG_LICENSE="Apache-2.0, BSD 2-Clause, MIT"
NEOTERM_PKG_LICENSE_FILE="LICENSE, src/wasi-libc/LICENSE-MIT, src/wasi-libc/libc-bottom-half/cloudlibc/LICENSE"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=20
NEOTERM_PKG_SRCURL=https://github.com/WebAssembly/wasi-sdk/archive/refs/tags/wasi-sdk-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=28f317520d9b522134f7a014b84833d91ab1329fbd697bad05aa4fcfa2746c83
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_NO_STATICSPLIT=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_post_get_source() {
	local WASI_LIBC_SRCURL="https://github.com/WebAssembly/wasi-libc/archive/refs/tags/wasi-sdk-${NEOTERM_PKG_VERSION}.tar.gz"
	local WASI_LIBC_SHA256=0a1c09c8c1da62a1ba214254ff4c9db6b60979c00f648a5eae33831d6ee2840e
	local LLVM_VERSION=$(. "${NEOTERM_SCRIPTDIR}/packages/libllvm/build.sh"; echo ${NEOTERM_PKG_VERSION})
	local LLVM_SRCURL="https://github.com/llvm/llvm-project/releases/download/llvmorg-${LLVM_VERSION}/llvm-project-${LLVM_VERSION}.src.tar.xz"
	local LLVM_SHA256=58a8818c60e6627064f312dbf46c02d9949956558340938b71cf731ad8bc0813

	neoterm_download \
		"${WASI_LIBC_SRCURL}" \
		"${NEOTERM_PKG_CACHEDIR}/wasi-libc-${NEOTERM_PKG_VERSION}.tar.gz" \
		"${WASI_LIBC_SHA256}"
	neoterm_download \
		"${LLVM_SRCURL}" \
		"${NEOTERM_PKG_CACHEDIR}/$(basename "${LLVM_SRCURL}")" \
		"${LLVM_SHA256}"

	tar -xf "${NEOTERM_PKG_CACHEDIR}/wasi-libc-${NEOTERM_PKG_VERSION}.tar.gz" -C src
	tar -xf "${NEOTERM_PKG_CACHEDIR}/llvm-project-${LLVM_VERSION}.src.tar.xz" -C src
	rm -frv src/{config,llvm-project,wasi-libc}
	mv -v "src/wasi-libc-wasi-sdk-${NEOTERM_PKG_VERSION}" src/wasi-libc
	mv -v "src/llvm-project-${LLVM_VERSION}.src" src/llvm-project
}

neoterm_step_pre_configure() {
	neoterm_setup_cmake
	neoterm_setup_ninja

	if [[ "${NEOTERM_ON_DEVICE_BUILD}" == "false" ]]; then
		# https://github.com/android/ndk/issues/1960
		# use NDK r26 new wasm target support to build
		# but need to fix non standard stdatomic.h without pollution
		rm -fr "${NEOTERM_PKG_TMPDIR}/toolchain"
		mkdir -p "${NEOTERM_PKG_TMPDIR}/toolchain"
		cp -fr "${NEOTERM_STANDALONE_TOOLCHAIN}"/{bin,include,lib} \
			"${NEOTERM_PKG_TMPDIR}/toolchain"
		sed \
			-e "s|#include <sys/cdefs.h>|//#include <sys/cdefs.h>|" \
			-i "${NEOTERM_PKG_TMPDIR}"/toolchain/lib/clang/*/include/stdatomic.h \
			-i "${NEOTERM_PKG_TMPDIR}"/toolchain/lib/clang/*/include/bits/stdatomic.h
		export CC="${NEOTERM_PKG_TMPDIR}/toolchain/bin/clang"
		export CXX="${NEOTERM_PKG_TMPDIR}/toolchain/bin/clang++"
		export PATH="${NEOTERM_PKG_TMPDIR}/toolchain/bin:${PATH}"
	fi
	export AR=$(command -v llvm-ar)
	export NM=$(command -v llvm-nm)
	export INSTALL_DIR="${NEOTERM_PREFIX}/share/wasi-sysroot"
	export NINJA_FLAGS="-j ${NEOTERM_MAKE_PROCESSES}"

	sed \
		-e "s|CC=\$(BUILD_PREFIX).*|CC=${CC} \\\\|g" \
		-e "s|AR=\$(BUILD_PREFIX).*|AR=${AR} \\\\|g" \
		-e "s|NM=\$(BUILD_PREFIX).*|NM=${NM} \\\\|g" \
		-e "s|cp -R \$(ROOT_DIR)/build/llvm/|#cp -R \$(ROOT_DIR)/build/llvm/|g" \
		-i Makefile
	sed \
		-e "/^set(CMAKE_C_COMPILER .*/d" \
		-e "/^set(CMAKE_CXX_COMPILER .*/d" \
		-e "/^set(CMAKE_ASM_COMPILER .*/d" \
		-e "/^set(CMAKE_AR .*/d" \
		-e "/^set(CMAKE_NM .*/d" \
		-e "/^set(CMAKE_RANLIB .*/d" \
		-i wasi-sdk.cmake wasi-sdk-pthread.cmake

	mkdir -p build
	touch build/llvm.BUILT # use our own LLVM
	touch build/config.BUILT # use our own autoconf config.guess
}

neoterm_step_make_install() {
	cp -fr "build/install/${NEOTERM_PREFIX}" "$(dirname "${NEOTERM_PREFIX}")"
	install -v -Dm644 -t "${NEOTERM_PREFIX}/share/cmake" \
		wasi-sdk.cmake \
		wasi-sdk-pthread.cmake
	install -v -Dm644 -t "${NEOTERM_PREFIX}/share/cmake/Platform" \
		cmake/Platform/WASI.cmake
}
