NEOTERM_PKG_HOMEPAGE=https://emscripten.org
NEOTERM_PKG_DESCRIPTION="Emscripten: An LLVM-to-WebAssembly Compiler"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="3.1.55"
NEOTERM_PKG_SRCURL=git+https://github.com/emscripten-core/emscripten
NEOTERM_PKG_GIT_BRANCH=${NEOTERM_PKG_VERSION}
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_DEPENDS="emscripten-binaryen, emscripten-llvm"
NEOTERM_PKG_RECOMMENDS="nodejs-lts | nodejs, python"
NEOTERM_PKG_HOSTBUILD=true
NEOTERM_PKG_NO_STATICSPLIT=true
NEOTERM_PKG_AUTO_UPDATE=true

# remove files according to emsdk/upstream directory after running
# ./emsdk install latest
NEOTERM_PKG_RM_AFTER_INSTALL="
opt/emscripten-llvm/bin/amdgpu-arch
opt/emscripten-llvm/bin/clang-check
opt/emscripten-llvm/bin/clang-cl
opt/emscripten-llvm/bin/clang-cpp
opt/emscripten-llvm/bin/clang-extdef-mapping
opt/emscripten-llvm/bin/clang-format
opt/emscripten-llvm/bin/clang-func-mapping
opt/emscripten-llvm/bin/clang-import-test
opt/emscripten-llvm/bin/clang-linker-wrapper
opt/emscripten-llvm/bin/clang-nvlink-wrapper
opt/emscripten-llvm/bin/clang-offload-bundler
opt/emscripten-llvm/bin/clang-offload-packager
opt/emscripten-llvm/bin/clang-offload-wrapper
opt/emscripten-llvm/bin/clang-pseudo
opt/emscripten-llvm/bin/clang-refactor
opt/emscripten-llvm/bin/clang-rename
opt/emscripten-llvm/bin/clang-repl
opt/emscripten-llvm/bin/clang-scan-deps
opt/emscripten-llvm/bin/diagtool
opt/emscripten-llvm/bin/git-clang-format
opt/emscripten-llvm/bin/hmaptool
opt/emscripten-llvm/bin/ld.lld
opt/emscripten-llvm/bin/ld64.lld
opt/emscripten-llvm/bin/ld64.lld.darwin*
opt/emscripten-llvm/bin/lld-link
opt/emscripten-llvm/bin/llvm-cov
opt/emscripten-llvm/bin/llvm-lib
opt/emscripten-llvm/bin/llvm-ml
opt/emscripten-llvm/bin/llvm-pdbutil
opt/emscripten-llvm/bin/llvm-profdata
opt/emscripten-llvm/bin/llvm-rc
opt/emscripten-llvm/bin/llvm-strings
opt/emscripten-llvm/bin/nvptx-arch
opt/emscripten-llvm/lib/libclang.so*
opt/emscripten-llvm/share
opt/emscripten/LICENSE
"

# https://github.com/emscripten-core/emscripten/issues/11362
# can switch to stable LLVM to save space once above is fixed
_LLVM_COMMIT=6c7805d5d186a6d1263f90b8033ad85e2d2633d7
_LLVM_TGZ_SHA256=ca16158a37923eba027cc6354539caee53fd980530c844ab531e7aceb3da98e6

# https://github.com/emscripten-core/emscripten/issues/12252
# upstream says better bundle the right binaryen revision for now
_BINARYEN_COMMIT=2ca9638354e4a5f260ced04d186808fc8b498986
_BINARYEN_TGZ_SHA256=8cf53d127761d07380e3a84e7e9cfe12e5981c760db9519a76ba55c49554676e

# https://github.com/emscripten-core/emsdk/blob/main/emsdk.py
# https://chromium.googlesource.com/emscripten-releases/+/refs/heads/main/src/build.py
# https://github.com/llvm/llvm-project
_LLVM_BUILD_ARGS="
-DCMAKE_BUILD_TYPE=MinSizeRel
-DCMAKE_BUILD_WITH_INSTALL_RPATH=ON
-DCMAKE_CROSSCOMPILING=ON
-DCMAKE_INSTALL_PREFIX=${NEOTERM_PREFIX}/opt/emscripten-llvm

-DDEFAULT_SYSROOT=$(dirname ${NEOTERM_PREFIX})
-DGENERATOR_IS_MULTI_CONFIG=ON
-DLLVM_ENABLE_ASSERTIONS=ON
-DLLVM_ENABLE_BINDINGS=OFF
-DLLVM_ENABLE_LIBEDIT=OFF
-DLLVM_ENABLE_LIBPFM=OFF
-DLLVM_ENABLE_LIBXML2=OFF
-DLLVM_ENABLE_LTO=Thin
-DLLVM_ENABLE_PROJECTS=clang;compiler-rt;lld
-DLLVM_ENABLE_TERMINFO=OFF
-DLLVM_INCLUDE_BENCHMARKS=OFF
-DLLVM_INCLUDE_EXAMPLES=OFF
-DLLVM_INCLUDE_TESTS=OFF
-DLLVM_INCLUDE_UTILS=OFF
-DLLVM_INSTALL_TOOLCHAIN_ONLY=ON
-DLLVM_LINK_LLVM_DYLIB=ON
-DLLVM_NATIVE_TOOL_DIR=${NEOTERM_PKG_HOSTBUILD_DIR}/bin

-DCLANG_DEFAULT_LINKER=lld
-DCLANG_ENABLE_ARCMT=OFF
-DCLANG_ENABLE_STATIC_ANALYZER=OFF

-DCOMPILER_RT_BUILD_CRT=OFF
-DCOMPILER_RT_BUILD_LIBFUZZER=OFF
-DCOMPILER_RT_BUILD_MEMPROF=OFF
-DCOMPILER_RT_BUILD_PROFILE=OFF
-DCOMPILER_RT_BUILD_SANITIZERS=OFF
-DCOMPILER_RT_BUILD_XRAY=OFF
-DCOMPILER_RT_INCLUDE_TESTS=OFF
"

# https://github.com/WebAssembly/binaryen/blob/main/CMakeLists.txt
_BINARYEN_BUILD_ARGS="
-DCMAKE_INSTALL_PREFIX=${NEOTERM_PREFIX}/opt/emscripten-binaryen
-DBUILD_TESTS=OFF
-DBYN_ENABLE_LTO=ON
"

# based on scripts/updates/internal/neoterm_github_auto_update.sh
neoterm_pkg_auto_update() {
	local latest_tag
	latest_tag=$(neoterm_github_api_get_tag "${NEOTERM_PKG_SRCURL}" "${NEOTERM_PKG_UPDATE_TAG_TYPE}")

	if [[ -z "${latest_tag}" ]]; then
		neoterm_error_exit "ERROR: Unable to get tag from ${NEOTERM_PKG_SRCURL}"
	fi

	if [[ "${latest_tag}" == "${NEOTERM_PKG_VERSION}" ]]; then
		echo "INFO: No update needed. Already at version '${NEOTERM_PKG_VERSION}'."
		return
	fi

	# https://github.com/emscripten-core/emscripten/blob/main/docs/packaging.md
	# https://github.com/archlinux/svntogit-community/tree/packages/emscripten/trunk
	# below generates commit hash for the deps according to emscripten releases
	local tmpdir=$(mktemp -d)
	local releases_tags release_tag deps_revision deps_json llvm_commit binaryen_commit llvm_tgz_sha256 binaryen_tgz_sha256
	releases_tags=$(curl -s https://raw.githubusercontent.com/emscripten-core/emsdk/main/emscripten-releases-tags.json)
	release_tag=$(echo "${releases_tags}" | python3 -c "import json,sys;print(json.load(sys.stdin)[\"releases\"][\"${latest_tag}\"])")
	deps_revision=$(curl -s "https://chromium.googlesource.com/emscripten-releases/+/${release_tag}/DEPS?format=text" | base64 -d | grep "_revision':" | sed -e "s|'|\"|g")
	deps_json=$(echo -e "{\n${deps_revision}EOL" | sed -e "s|,EOL|\n}|")
	llvm_commit=$(echo "${deps_json}" | python3 -c "import json,sys;print(json.load(sys.stdin)[\"llvm_project_revision\"])")
	binaryen_commit=$(echo "${deps_json}" | python3 -c "import json,sys;print(json.load(sys.stdin)[\"binaryen_revision\"])")
	curl -LC - "https://github.com/llvm/llvm-project/archive/${llvm_commit}.tar.gz" -o "${tmpdir}/${llvm_commit}.tar.gz"
	curl -LC - "https://github.com/WebAssembly/binaryen/archive/${binaryen_commit}.tar.gz" -o "${tmpdir}/${binaryen_commit}.tar.gz"
	llvm_tgz_sha256=$(sha256sum "${tmpdir}/${llvm_commit}.tar.gz" | sed -e "s| .*$||")
	binaryen_tgz_sha256=$(sha256sum "${tmpdir}/${binaryen_commit}.tar.gz" | sed -e "s| .*$||")

	cat <<- EOL
	INFO: Generated *.tar.gz checksum for:
	_LLVM_COMMIT     ${llvm_commit} = ${llvm_tgz_sha256}
	_BINARYEN_COMMIT ${binaryen_commit} = ${binaryen_tgz_sha256}
	EOL

	sed -i "${NEOTERM_PKG_BUILDER_DIR}/build.sh" \
		-e "s|^_LLVM_COMMIT=.*|_LLVM_COMMIT=${llvm_commit}|" \
		-e "s|^_LLVM_TGZ_SHA256=.*|_LLVM_TGZ_SHA256=${llvm_tgz_sha256}|" \
		-e "s|^_BINARYEN_COMMIT=.*|_BINARYEN_COMMIT=${binaryen_commit}|" \
		-e "s|^_BINARYEN_TGZ_SHA256=.*|_BINARYEN_TGZ_SHA256=${binaryen_tgz_sha256}|"

	rm -fr "${tmpdir}"

	neoterm_pkg_upgrade_version "$latest_tag"
}

neoterm_step_post_get_source() {
	neoterm_download \
		"https://github.com/llvm/llvm-project/archive/${_LLVM_COMMIT}.tar.gz" \
		"${NEOTERM_PKG_CACHEDIR}/llvm.tar.gz" \
		"${_LLVM_TGZ_SHA256}"
	neoterm_download \
		"https://github.com/WebAssembly/binaryen/archive/${_BINARYEN_COMMIT}.tar.gz" \
		"${NEOTERM_PKG_CACHEDIR}/binaryen.tar.gz" \
		"${_BINARYEN_TGZ_SHA256}"
	tar -xf "${NEOTERM_PKG_CACHEDIR}/llvm.tar.gz" -C "${NEOTERM_PKG_CACHEDIR}"
	tar -xf "${NEOTERM_PKG_CACHEDIR}/binaryen.tar.gz" -C "${NEOTERM_PKG_CACHEDIR}"

	local llvm_patches=$(find "${NEOTERM_PKG_BUILDER_DIR}" -mindepth 1 -maxdepth 1 -type f -name 'llvm-project-*.patch.diff')
	if [[ -n "${llvm_patches}" ]]; then
		pushd "${NEOTERM_PKG_CACHEDIR}/llvm-project-${_LLVM_COMMIT}"
		for patch in ${llvm_patches}; do
			patch -p1 -i "${patch}" || :
		done
		local llvm_patches_rej=$(find . -type f -name '*.rej')
		if [[ -n "${llvm_patches_rej}" ]]; then
			echo "INFO: Patch failed! Printing *.rej files ..."
			for rej in ${llvm_patches_rej}; do
				echo -e "\n\n${rej}"
				cat "${rej}"
			done
			neoterm_error_exit "Patch failed! Please check patch errors above!"
		fi
		popd
	fi

	local binaryen_patches=$(find "${NEOTERM_PKG_BUILDER_DIR}" -mindepth 1 -maxdepth 1 -type f -name 'binaryen-*.patch.diff')
	if [[ -n "${binaryen_patches}" ]]; then
		pushd "${NEOTERM_PKG_CACHEDIR}/binaryen-${_BINARYEN_COMMIT}"
		for patch in ${binaryen_patches}; do
			patch -p1 -i "${patch}" || :
		done
		local binaryen_patches_rej=$(find . -type f -name '*.rej')
		if [[ -n "${binaryen_patches_rej}" ]]; then
			echo "INFO: Patch failed! Printing *.rej files ..."
			for rej in ${binaryen_patches_rej}; do
				echo -e "\n\n${rej}"
				cat "${rej}"
			done
			neoterm_error_exit "Patch failed! Please check patch errors above!"
		fi
		popd
	fi
}

neoterm_step_host_build() {
	neoterm_setup_cmake
	neoterm_setup_ninja

	cmake \
		-G Ninja \
		-S "${NEOTERM_PKG_CACHEDIR}/llvm-project-${_LLVM_COMMIT}/llvm" \
		-DCMAKE_BUILD_TYPE=Release \
		-DLLVM_ENABLE_PROJECTS=clang \
		-DLLVM_INCLUDE_BENCHMARKS=OFF \
		-DLLVM_INCLUDE_EXAMPLES=OFF \
		-DLLVM_INCLUDE_TESTS=OFF \
		-DLLVM_INCLUDE_UTILS=OFF
	ninja \
		-C "${NEOTERM_PKG_HOSTBUILD_DIR}" \
		-j "${NEOTERM_MAKE_PROCESSES}" \
		llvm-tblgen clang-tblgen
}

neoterm_step_pre_configure() {
	# https://github.com/neoterm/neoterm-packages/issues/16358
	# TODO libclang-cpp.so* is not affected
	if [[ "${NEOTERM_ON_DEVICE_BUILD}" == "true" ]]; then
		echo "WARN: ld.lld wrapper is not working for on-device builds. Skipping."
		return
	fi

	local _WRAPPER_BIN=${NEOTERM_PKG_BUILDDIR}/_wrapper/bin
	mkdir -p "${_WRAPPER_BIN}"
	ln -fs "${NEOTERM_STANDALONE_TOOLCHAIN}/bin/lld" "${_WRAPPER_BIN}/ld.lld"
	cat <<- EOF > "${_WRAPPER_BIN}/ld.lld.sh"
	#!/bin/bash
	tmpfile=\$(mktemp)
	python ${NEOTERM_PKG_BUILDER_DIR}/fix-rpath.py -rpath=${NEOTERM_PREFIX}/lib \$@ > \${tmpfile}
	args=\$(cat \${tmpfile})
	rm -f \${tmpfile}
	${_WRAPPER_BIN}/ld.lld \${args}
	EOF
	chmod +x "${_WRAPPER_BIN}/ld.lld.sh"
	rm -f "${NEOTERM_STANDALONE_TOOLCHAIN}/bin/ld.lld"
	ln -fs "${_WRAPPER_BIN}/ld.lld.sh" "${NEOTERM_STANDALONE_TOOLCHAIN}/bin/ld.lld"
}

neoterm_step_make() {
	neoterm_setup_cmake
	neoterm_setup_ninja

	# from packages/libllvm/build.sh
	local _LLVM_TARGET_TRIPLE=${NEOTERM_HOST_PLATFORM/-/-unknown-}${NEOTERM_PKG_API_LEVEL}
	local _LLVM_TARGET_ARCH
	case "${NEOTERM_ARCH}" in
	aarch64) _LLVM_TARGET_ARCH=AArch64 ;;
	arm) _LLVM_TARGET_ARCH=ARM ;;
	i686|x86_64) _LLVM_TARGET_ARCH=X86 ;;
	*) neoterm_error_exit "Invalid arch: ${NEOTERM_ARCH}" ;;
	esac
	_LLVM_BUILD_ARGS+="
	-DLLVM_HOST_TRIPLE=${_LLVM_TARGET_TRIPLE}
	-DLLVM_TARGET_ARCH=${_LLVM_TARGET_ARCH}
	-DLLVM_TARGETS_TO_BUILD=WebAssembly;${_LLVM_TARGET_ARCH}
	"

	cmake \
		-G Ninja \
		-S "${NEOTERM_PKG_CACHEDIR}/llvm-project-${_LLVM_COMMIT}/llvm" \
		-B "${NEOTERM_PKG_BUILDDIR}/build-llvm" \
		${_LLVM_BUILD_ARGS}
	ninja \
		-C "${NEOTERM_PKG_BUILDDIR}/build-llvm" \
		-j "${NEOTERM_MAKE_PROCESSES}" \
		install

	cmake \
		-G Ninja \
		-S "${NEOTERM_PKG_CACHEDIR}/binaryen-${_BINARYEN_COMMIT}" \
		-B "${NEOTERM_PKG_BUILDDIR}/build-binaryen" \
		${_BINARYEN_BUILD_ARGS}
	ninja \
		-C "${NEOTERM_PKG_BUILDDIR}/build-binaryen" \
		-j "${NEOTERM_MAKE_PROCESSES}" \
		install
}

neoterm_step_make_install() {
	pushd "${NEOTERM_PKG_SRCDIR}"

	# https://github.com/emscripten-core/emscripten/pull/15840
	sed -e "s|-git||" -i "${NEOTERM_PKG_SRCDIR}/emscripten-version.txt"

	# skip using Makefile which does host npm install
	rm -fr "${NEOTERM_PREFIX}/opt/emscripten"
	./tools/install.py "${NEOTERM_PREFIX}/opt/emscripten"

	# subpackage optional third party test suite files
	cp -fr "${NEOTERM_PKG_SRCDIR}/test/third_party" "${NEOTERM_PREFIX}/opt/emscripten/test/third_party"

	# first run generates .emscripten and exits immediately
	rm -f "${NEOTERM_PKG_SRCDIR}/.emscripten"
	./emcc --generate-config
	sed -i .emscripten \
		-e "s|^EMSCRIPTEN_ROOT.*|EMSCRIPTEN_ROOT = '${NEOTERM_PREFIX}/opt/emscripten' # directory|" \
		-e "s|^LLVM_ROOT.*|LLVM_ROOT = '${NEOTERM_PREFIX}/opt/emscripten-llvm/bin' # directory|" \
		-e "s|^BINARYEN_ROOT.*|BINARYEN_ROOT = '${NEOTERM_PREFIX}/opt/emscripten-binaryen' # directory|" \
		-e "s|^NODE_JS.*|NODE_JS = '${NEOTERM_PREFIX}/bin/node' # executable|"
	grep "${NEOTERM_PREFIX}" "${NEOTERM_PKG_SRCDIR}/.emscripten"
	install -Dm644 "${NEOTERM_PKG_SRCDIR}/.emscripten" "${NEOTERM_PREFIX}/opt/emscripten/.emscripten"

	# add emscripten directory to PATH var
	cat <<- EOF > "${NEOTERM_PKG_TMPDIR}/emscripten.sh"
	#!${NEOTERM_PREFIX}/bin/sh
	export PATH=\${PATH}:${NEOTERM_PREFIX}/opt/emscripten
	EOF
	install -Dm644 "${NEOTERM_PKG_TMPDIR}/emscripten.sh" "${NEOTERM_PREFIX}/etc/profile.d/emscripten.sh"

	# add useful tools not installed by LLVM_INSTALL_TOOLCHAIN_ONLY=ON
	for tool in llvm-{addr2line,dwarfdump,dwp,link,nm,objdump,ranlib,readobj,size,strings}; do
		install -Dm755 "${NEOTERM_PKG_BUILDDIR}/build-llvm/bin/${tool}" "${NEOTERM_PREFIX}/opt/emscripten-llvm/bin/${tool}"
	done

	# wasm32 triplets
	rm -fr "${NEOTERM_PREFIX}"/opt/emscripten-llvm/bin/wasm32-{clang,clang++,wasi-clang,wasi-clang++}
	rm -fr "${NEOTERM_PREFIX}/opt/emscripten-llvm/bin/wasm-ld"
	ln -fs "clang"   "${NEOTERM_PREFIX}/opt/emscripten-llvm/bin/wasm32-clang"
	ln -fs "clang++" "${NEOTERM_PREFIX}/opt/emscripten-llvm/bin/wasm32-clang++"
	ln -fs "clang"   "${NEOTERM_PREFIX}/opt/emscripten-llvm/bin/wasm32-wasi-clang"
	ln -fs "clang++" "${NEOTERM_PREFIX}/opt/emscripten-llvm/bin/wasm32-wasi-clang++"
	ln -fs "lld"     "${NEOTERM_PREFIX}/opt/emscripten-llvm/bin/wasm-ld"

	# neoterm_step_massage strip does not cover opt dir
	find "${NEOTERM_PREFIX}/opt" \( \
		-path "*/emscripten-llvm/bin/*" -o \
		-path "*/emscripten-llvm/lib/*" -o \
		-path "*/emscripten-binaryen/bin/*" -o \
		-path "*/emscripten-binaryen/lib/*" \
	\) -type f -print0 | \
		xargs -0 -r file | grep -E "ELF .+ (executable|shared object)" | \
		cut -d":" -f1 | xargs -r "${STRIP}" --strip-unneeded --preserve-dates

	popd
}

neoterm_step_create_debscripts() {
	# emscripten's package-lock.json is generated with nodejs v12.13.0
	# which comes with npm v6 which used lockfile version 1
	# which isn't compatible with lockfile version 2 used in npm v7 and v8
	cat <<- EOF > postinst
	#!${NEOTERM_PREFIX}/bin/sh
	DIR="${NEOTERM_PREFIX}/opt/emscripten"
	cd "\${DIR}"
	if [ -n "\$(command -v npm)" ]; then
	if [ -n "\$(npm --version | grep "^6.")" ]; then
	CMD="ci --production --no-optional"
	else
	CMD="install --omit=dev --omit=optional"
	rm package-lock.json
	fi
	echo "Running 'npm \${CMD}' in \${DIR} ..."
	npm \${CMD}
	else
	echo '
	WARNING: npm is not installed! Emscripten may not work properly without installing node modules!
	' >&2
	fi
	echo '
	===== Post-install notice =====

	Please start a new session to use Emscripten.
	You may want to clear the cache by running
	the command below to fix issues.

	emcc --clear-cache

	===== Post-install notice =====
	'
	EOF

	cat <<- EOF > postrm
	#!${NEOTERM_PREFIX}/bin/sh
	case "\$1" in
	purge|remove)
	rm -fr "${NEOTERM_PREFIX}/opt/emscripten"
	esac
	EOF
}
