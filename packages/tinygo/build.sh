NEOTERM_PKG_HOMEPAGE=https://tinygo.org
NEOTERM_PKG_DESCRIPTION="Go compiler for microcontrollers, WASM, CLI tools"
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="LICENSE"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.30.0"
NEOTERM_PKG_SRCURL=git+https://github.com/tinygo-org/tinygo
NEOTERM_PKG_GIT_BRANCH="v${NEOTERM_PKG_VERSION}"
NEOTERM_PKG_SHA256=4ecb1764af87efcd90fcc66cb3b25d7cf3c038fceb87d032155170a4a3c65614
NEOTERM_PKG_DEPENDS="libc++, tinygo-common"
NEOTERM_PKG_RECOMMENDS="binaryen, golang"
NEOTERM_PKG_NO_STATICSPLIT=true
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_HOSTBUILD=true
NEOTERM_PKG_AUTO_UPDATE=true

_LLVM_OPTION="
-DCMAKE_BUILD_TYPE=MinSizeRel
-DGENERATOR_IS_MULTI_CONFIG=ON
-DLLVM_ENABLE_LTO=Thin
-DLLVM_TABLEGEN=${NEOTERM_PKG_HOSTBUILD_DIR}/bin/llvm-tblgen
-DCLANG_TABLEGEN=${NEOTERM_PKG_HOSTBUILD_DIR}/bin/clang-tblgen
"

_LLVM_EXTRA_BUILD_TARGETS="
lib/libLLVMDWARFLinker.a
lib/libLLVMDWARFLinkerParallel.a
lib/libLLVMDWP.a
lib/libLLVMDebugInfoGSYM.a
lib/libLLVMDebugInfoLogicalView.a
lib/libLLVMFileCheck.a
lib/libLLVMFrontendOpenACC.a
lib/libLLVMFuzzMutate.a
lib/libLLVMFuzzerCLI.a
lib/libLLVMInterfaceStub.a
lib/libLLVMJITLink.a
lib/libLLVMLineEditor.a
lib/libLLVMMIRParser.a
lib/libLLVMObjCopy.a
lib/libLLVMObjectYAML.a
lib/libLLVMOrcJIT.a
lib/libLLVMXRay.a
"

neoterm_pkg_auto_update() {
	local e=0
	local latest_tag
	latest_tag=$(neoterm_github_api_get_tag "${NEOTERM_PKG_SRCURL}" "${NEOTERM_PKG_UPDATE_TAG_TYPE}")
	if [[ "${latest_tag}" == "${NEOTERM_PKG_VERSION}" ]]; then
		echo "INFO: No update needed. Already at version '${NEOTERM_PKG_VERSION}'."
		return
	fi
	[[ -z "${latest_tag}" ]] && e=1

	local uptime_now=$(cat /proc/uptime)
	local uptime_s="${uptime_now//.*}"
	local uptime_h_limit=1
	local uptime_s_limit=$((uptime_h_limit*60*60))
	[[ -z "${uptime_s}" ]] && e=1
	[[ "${uptime_s}" == 0 ]] && e=1
	[[ "${uptime_s}" -gt "${uptime_s_limit}" ]] && e=1

	if [[ "${e}" != 0 ]]; then
		cat <<- EOL >&2
		WARN: Auto update failure!
		latest_tag=${latest_tag}
		uptime_now=${uptime_now}
		uptime_s=${uptime_s}
		uptime_s_limit=${uptime_s_limit}
		EOL
		return
	fi

	local tmpdir=$(mktemp -d)
	git clone --branch "v${latest_tag}" --depth=1 --recursive \
		"${NEOTERM_PKG_SRCURL#git+}" "${tmpdir}"
	make -C "${tmpdir}" llvm-source GO=:
	local s=$(
		find "${tmpdir}" -type f ! -path '*/.git/*' -print0 | xargs -0 sha256sum | \
		cut -d" " -f1 | LC_ALL=C sort | sha256sum | cut -d" " -f1
	)

	sed \
		-e "s|^NEOTERM_PKG_SHA256=.*|NEOTERM_PKG_SHA256=${s}|" \
		-i "${NEOTERM_PKG_BUILDER_DIR}/build.sh"

	rm -fr "${tmpdir}"

	echo "INFO: Generated checksum: ${s}"
	neoterm_pkg_upgrade_version "${latest_tag}"
}

neoterm_step_post_get_source() {
	# https://github.com/tinygo-org/tinygo/blob/release/Makefile
	# https://github.com/espressif/llvm-project
	make llvm-source GO=:

	local s=$(
		find . -type f ! -path '*/.git/*' -print0 | xargs -0 sha256sum | \
		cut -d" " -f1 | LC_ALL=C sort | sha256sum | cut -d" " -f1
	)
	if [[ "${s}" != "${NEOTERM_PKG_SHA256}" ]]; then
		neoterm_error_exit "
		Checksum mismatch for source files!
		Expected = ${NEOTERM_PKG_SHA256}
		Actual   = ${s}
		"
	fi
}

neoterm_step_host_build() {
	neoterm_setup_golang
	neoterm_setup_cmake
	neoterm_setup_ninja

	pushd "${NEOTERM_PKG_SRCDIR}"
	make "${NEOTERM_PKG_HOSTBUILD_DIR}" \
		LLVM_BUILDDIR="${NEOTERM_PKG_HOSTBUILD_DIR}"

	# build whatever llvm-config think is missing
	ninja \
		-C "${NEOTERM_PKG_HOSTBUILD_DIR}" \
		-j "${NEOTERM_MAKE_PROCESSES}" \
		${_LLVM_EXTRA_BUILD_TARGETS}

	echo "===== llvm-config ====="
	file "${NEOTERM_PKG_HOSTBUILD_DIR}/bin/llvm-config"
	"${NEOTERM_PKG_HOSTBUILD_DIR}/bin/llvm-config" --cppflags
	"${NEOTERM_PKG_HOSTBUILD_DIR}/bin/llvm-config" --ldflags --libs --system-libs
	echo "===== llvm-config ====="

	make build/release \
		LLVM_BUILDDIR="${NEOTERM_PKG_HOSTBUILD_DIR}" \
		CLANG="${NEOTERM_PKG_HOSTBUILD_DIR}/bin/clang" \
		LLVM_AR="${NEOTERM_PKG_HOSTBUILD_DIR}/bin/llvm-ar" \
		LLVM_NM="${NEOTERM_PKG_HOSTBUILD_DIR}/bin/llvm-nm" \
		USE_SYSTEM_BINARYEN=1
	popd
}

neoterm_step_pre_configure() {
	# https://github.com/juic3b0x/neoterm-packages/issues/16358
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
	neoterm_setup_golang
	neoterm_setup_cmake
	neoterm_setup_ninja

	# from packages/libllvm/build.sh
	local _LLVM_TARGET_TRIPLE=${NEOTERM_HOST_PLATFORM/-/-unknown-}${NEOTERM_PKG_API_LEVEL}
	local _LLVM_TARGET_ARCH
	case "${NEOTERM_ARCH}" in
	aarch64) _LLVM_TARGET_ARCH="AArch64" ;;
	arm) _LLVM_TARGET_ARCH="ARM" ;;
	i686|x86_64) _LLVM_TARGET_ARCH="X86" ;;
	*) neoterm_error_exit "Invalid arch: ${NEOTERM_ARCH}" ;;
	esac
	_LLVM_OPTION+="
	-DLLVM_HOST_TRIPLE=${_LLVM_TARGET_TRIPLE}
	-DLLVM_TARGET_ARCH=${_LLVM_TARGET_ARCH}
	"

	make llvm-build LLVM_OPTION="$(echo ${_LLVM_OPTION})"

	ninja \
		-C llvm-build \
		-j "${NEOTERM_MAKE_PROCESSES}" \
		${_LLVM_EXTRA_BUILD_TARGETS}

	# replace Android llvm-config with wrapper around host build
	cat <<- EOF > llvm-build/bin/llvm-config
	#!/bin/bash
	${NEOTERM_PKG_HOSTBUILD_DIR}/bin/llvm-config "\$@" | \
	sed \
	-e "s|${NEOTERM_PKG_HOSTBUILD_DIR}|${NEOTERM_PKG_SRCDIR}/llvm-build|g" \
	-e "s|-lrt|-lc|g"
	EOF

	make tinygo
	mkdir -p build/release/tinygo/bin
	cp -fv build/tinygo build/release/tinygo/bin

	# skip make gen-device, done in host build
	# skip make wasi-libc, NDK doesnt support wasm32-unknown-wasi
	# skip make binaryen

	# check excessive runpath entries
	local tinygo_readelf=$(readelf -dW build/release/tinygo/bin/tinygo)
	local tinygo_runpath=$(echo "${tinygo_readelf}" | sed -ne "s|.*RUNPATH.*\[\(.*\)\].*|\1|p")
	if [[ "${tinygo_runpath}" != "${NEOTERM_PREFIX}/lib" ]]; then
		neoterm_error_exit "
		Excessive RUNPATH found. Check readelf output below:
		${tinygo_readelf}
		"
	fi
}

neoterm_step_make_install() {
	mkdir -p "${NEOTERM_PREFIX}/lib/tinygo"
	cp -fr "${NEOTERM_PKG_SRCDIR}/build/release/tinygo" "${NEOTERM_PREFIX}/lib"
	ln -fsv "../lib/tinygo/bin/tinygo" "${NEOTERM_PREFIX}/bin/tinygo"
}
