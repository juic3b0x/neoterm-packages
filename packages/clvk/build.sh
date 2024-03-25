NEOTERM_PKG_HOMEPAGE=https://github.com/kpet/clvk
NEOTERM_PKG_DESCRIPTION="Experimental implementation of OpenCL on Vulkan"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
_COMMIT=0c6a3e34cc2c62c8d938a41eced86affea689201
_COMMIT_DATE=20240309
_COMMIT_TIME=174732
NEOTERM_PKG_VERSION="0.0.20240309.174732"
NEOTERM_PKG_SRCURL=git+https://github.com/kpet/clvk
NEOTERM_PKG_GIT_BRANCH=main
NEOTERM_PKG_BUILD_DEPENDS="vulkan-headers, vulkan-loader-android"
NEOTERM_PKG_DEPENDS="libc++, vulkan-loader"
NEOTERM_PKG_ANTI_BUILD_DEPENDS="vulkan-loader"
NEOTERM_PKG_RECOMMENDS="ocl-icd"
NEOTERM_PKG_HOSTBUILD=true
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DCLVK_BUILD_TESTS=ON
-DCLVK_CLSPV_ONLINE_COMPILER=ON
-DCLVK_VULKAN_IMPLEMENTATION=custom
-DLLVM_INCLUDE_BENCHMARKS=OFF
-DLLVM_INCLUDE_EXAMPLES=OFF
-DLLVM_NATIVE_TOOL_DIR=${NEOTERM_PKG_HOSTBUILD_DIR}/bin
-DVulkan_INCLUDE_DIRS=${NEOTERM_PREFIX}/include
"

neoterm_pkg_auto_update() {
	local api_url="https://api.github.com/repos/kpet/clvk/commits"
	local latest_commit=$(curl -s "${api_url}"| jq .[].sha | head -n1 | sed -e 's|\"||g')
	if [[ -z "${latest_commit}" ]]; then
		echo "WARN: Unable to get latest commit from upstream" >&2
		return
	fi
	if [[ "${latest_commit}" == "${_COMMIT}" ]]; then
		echo "INFO: No update needed. Already at version '${NEOTERM_PKG_VERSION}'."
		return
	fi

	local latest_commit_date_tz=$(curl -s "${api_url}/${latest_commit}" | jq .commit.committer.date | sed -e 's|\"||g')
	if [[ -z "${latest_commit_date_tz}" ]]; then
		neoterm_error_exit "ERROR: Unable to get latest commit date info"
	fi

	local latest_commit_date=$(echo "${latest_commit_date_tz}" | sed -e 's|\(.*\)T\(.*\)Z|\1|' -e 's|\-||g')
	local latest_commit_time=$(echo "${latest_commit_date_tz}" | sed -e 's|\(.*\)T\(.*\)Z|\2|' -e 's|\:||g')

	# https://github.com/neoterm/neoterm-packages/issues/11827
	local latest_version="0.0.${latest_commit_date}.${latest_commit_time}"

	local current_date_epoch=$(date "+%s")
	local _COMMIT_DATE_epoch=$(date -d "${_COMMIT_DATE}" "+%s")
	local current_date_diff=$(((current_date_epoch-_COMMIT_DATE_epoch)/(60*60*24)))
	local cooldown_days=14
	if [[ "${current_date_diff}" -lt "${cooldown_days}" ]]; then
		cat <<- EOL
		INFO: Queuing updates since last push
		Cooldown (days) = ${cooldown_days}
		Days since      = ${current_date_diff}
		EOL
		return
	fi

	if ! dpkg --compare-versions "${latest_version}" gt "${NEOTERM_PKG_VERSION}"; then
		neoterm_error_exit "
		ERROR: Resulting latest version is not counted as an update!
		Latest version  = ${latest_version}
		Current version = ${NEOTERM_PKG_VERSION}
		"
	fi

	# unlikely to happen
	if [[ "${latest_commit_date}" -lt "${_COMMIT_DATE}" || \
		"${latest_commit_date}" -eq "${_COMMIT_DATE}" && "${latest_commit_time}" -lt "${_COMMIT_TIME}" ]]; then
		neoterm_error_exit "
		ERROR: Upstream is older than current package version!
		ERROR: Please report to upstream!
		"
	fi

	sed \
		-e "s|^_COMMIT=.*|_COMMIT=${latest_commit}|" \
		-e "s|^_COMMIT_DATE=.*|_COMMIT_DATE=${latest_commit_date}|" \
		-e "s|^_COMMIT_TIME=.*|_COMMIT_TIME=${latest_commit_time}|" \
		-i "${NEOTERM_PKG_BUILDER_DIR}/build.sh"

	neoterm_pkg_upgrade_version "${latest_version}" --skip-version-check
}

neoterm_step_post_get_source() {
	git fetch --unshallow
	git checkout "${_COMMIT}"
	git submodule update --init --recursive --depth=1
	git clean -ffxd
	./external/clspv/utils/fetch_sources.py --deps llvm --shallow
}

neoterm_step_host_build() {
	neoterm_setup_cmake
	neoterm_setup_ninja

	local _LLVM_TARGET_ARCH
	case "${NEOTERM_ARCH}" in
	aarch64) _LLVM_TARGET_ARCH="AArch64" ;;
	arm) _LLVM_TARGET_ARCH="ARM" ;;
	i686|x86_64) _LLVM_TARGET_ARCH="X86" ;;
	*) neoterm_error_exit "Invalid arch: ${NEOTERM_ARCH}" ;;
	esac

	cmake \
		-G Ninja \
		-S "${NEOTERM_PKG_SRCDIR}/external/clspv/third_party/llvm/llvm" \
		-DCMAKE_BUILD_TYPE=Release \
		-DLLVM_INCLUDE_BENCHMARKS=OFF \
		-DLLVM_INCLUDE_EXAMPLES=OFF \
		-DLLVM_INCLUDE_TESTS=OFF \
		-DLLVM_INCLUDE_UTILS=OFF \
		-DLLVM_ENABLE_PROJECTS=clang \
		-DLLVM_TARGETS_TO_BUILD="${_LLVM_TARGET_ARCH}"
	ninja \
		-C "${NEOTERM_PKG_HOSTBUILD_DIR}" \
		-j "${NEOTERM_MAKE_PROCESSES}" \
		llvm-tblgen clang-tblgen
}

neoterm_step_pre_configure() {
	local _libvulkan=vulkan
	if [[ "${NEOTERM_ON_DEVICE_BUILD}" == "false" && "${NEOTERM_PKG_API_LEVEL}" -lt 28 ]]; then
		_libvulkan="${NEOTERM_STANDALONE_TOOLCHAIN}/sysroot/usr/lib/${NEOTERM_HOST_PLATFORM}/28/libvulkan.so"
	fi
	NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" -DVulkan_LIBRARIES=${_libvulkan}"

	# from packages/libllvm/build.sh
	local _LLVM_TARGET_TRIPLE=${NEOTERM_HOST_PLATFORM/-/-unknown-}${NEOTERM_PKG_API_LEVEL}
	local _LLVM_TARGET_ARCH
	case "${NEOTERM_ARCH}" in
	aarch64) _LLVM_TARGET_ARCH="AArch64" ;;
	arm) _LLVM_TARGET_ARCH="ARM" ;;
	i686|x86_64) _LLVM_TARGET_ARCH="X86" ;;
	*) neoterm_error_exit "Invalid arch: ${NEOTERM_ARCH}" ;;
	esac
	NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+="
	-DLLVM_HOST_TRIPLE=${_LLVM_TARGET_TRIPLE}
	-DLLVM_TARGET_ARCH=${_LLVM_TARGET_ARCH}
	-DLLVM_TARGETS_TO_BUILD=${_LLVM_TARGET_ARCH}
	"

	export CFLAGS+=" -flto=thin"
	export CXXFLAGS+=" -flto=thin"

	# NEOTERM_DEBUG_BUILD doesnt have middle ground
	#NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" -DCMAKE_BUILD_TYPE=RelWithDebInfo"
	#export STRIP=:
}

neoterm_step_make_install() {
	# clvk does not have proper install rule yet
	install -Dm644 -t "${NEOTERM_PREFIX}/lib/clvk" "${NEOTERM_PKG_BUILDDIR}/libOpenCL.so"

	echo "${NEOTERM_PREFIX}/lib/clvk/libOpenCL.so" > "${NEOTERM_PKG_TMPDIR}/clvk.icd"
	install -Dm644 -t "${NEOTERM_PREFIX}/etc/OpenCL/vendors" "${NEOTERM_PKG_TMPDIR}/clvk.icd"
}

# https://github.com/kpet/clvk/blob/main/CMakeLists.txt

# Known issues:
# https://github.com/kpet/clvk/issues/375
# https://github.com/kpet/clvk/issues/499
# https://github.com/kpet/clvk/issues/544
# https://github.com/neoterm/neoterm-packages/issues/11827
