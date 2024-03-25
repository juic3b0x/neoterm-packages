NEOTERM_PKG_HOMEPAGE=https://github.com/KhronosGroup/SPIRV-Tools
NEOTERM_PKG_DESCRIPTION="SPIR-V Tools"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.3.261.1"
NEOTERM_PKG_SRCURL=https://github.com/KhronosGroup/SPIRV-Tools/archive/refs/tags/sdk-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=ead95c626ad482882a141d1aa0ce47b9453871f72c42c0b28d39c82f60a52008
NEOTERM_PKG_DEPENDS="libc++"
NEOTERM_PKG_BUILD_DEPENDS="spirv-headers (=${NEOTERM_PKG_VERSION})"
NEOTERM_PKG_NO_STATICSPLIT=true
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DSPIRV-Headers_SOURCE_DIR=${NEOTERM_PREFIX}
-DSPIRV_WERROR=OFF
"

neoterm_pkg_auto_update() {
	# use versions from sdk-* and not vYEAR.* to match spirv-headers
	local e=0
	local api_url="https://api.github.com/repos/KhronosGroup/SPIRV-Tools/git/refs/tags"
	local api_url_r=$(curl -s "${api_url}")
	local r1=$(echo "${api_url_r}" | jq .[].ref | sed -nE "s|.*/(sdk-.*)\"|\1|p")
	local latest_version=$(echo "${r1}" | tail -n1)
	[[ -z "${api_url_r}" ]] && e=1
	[[ -z "${r1}" ]] && e=1
	[[ -z "${latest_version}" ]] && e=1

	if [[ "${e}" != 0 ]]; then
		cat <<- EOL >&2
		WARN: Auto update failure!
		api_url_r=${api_url_r}
		r1=${r1}
		latest_version=${latest_version}
		EOL
		return
	fi

	neoterm_pkg_upgrade_version "${latest_version//sdk-}"
}
