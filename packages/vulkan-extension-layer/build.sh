NEOTERM_PKG_HOMEPAGE=https://github.com/KhronosGroup/Vulkan-ExtensionLayer
NEOTERM_PKG_DESCRIPTION="Vulkan Extension Layer"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.3.280"
NEOTERM_PKG_SRCURL=https://github.com/KhronosGroup/Vulkan-ExtensionLayer/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=e61122beaea6d74185702c11119d7d300d9759c8082d1cabc1ecf00db8f72cbc
NEOTERM_PKG_DEPENDS="libc++, vulkan-loader"
NEOTERM_PKG_BUILD_DEPENDS="vulkan-headers (=${NEOTERM_PKG_VERSION}), vulkan-loader-generic (=${NEOTERM_PKG_VERSION}), vulkan-utility-libraries (=${NEOTERM_PKG_VERSION})"
NEOTERM_PKG_ANTI_BUILD_DEPENDS="vulkan-loader"
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_TESTS=OFF
-DVULKAN_HEADERS_INSTALL_DIR=${NEOTERM_PREFIX}
"

neoterm_pkg_auto_update() {
	# Get latest release tag:
	local api_url="https://api.github.com/repos/KhronosGroup/Vulkan-ExtensionLayer/git/refs/tags"
	local latest_refs_tags=$(curl -s "${api_url}" | jq .[].ref | grep -oP v${NEOTERM_PKG_UPDATE_VERSION_REGEXP} | sort)
	if [[ -z "${latest_refs_tags}" ]]; then
		echo "WARN: Unable to get latest refs tags from upstream. Try again later." >&2
		return
	fi

	local latest_version=$(echo "${latest_refs_tags}" | tail -n1)
	if [[ "${latest_version}" == "${NEOTERM_PKG_VERSION}" ]]; then
		echo "INFO: No update needed. Already at version '${NEOTERM_PKG_VERSION}'."
		return
	fi

	neoterm_pkg_upgrade_version "${latest_version}"
}
