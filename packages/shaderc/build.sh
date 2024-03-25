NEOTERM_PKG_HOMEPAGE=https://github.com/google/shaderc
NEOTERM_PKG_DESCRIPTION="Collection of tools, libraries, and tests for Vulkan shader compilation"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2024.0"
NEOTERM_PKG_SRCURL=https://github.com/google/shaderc/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=c761044e4e204be8e0b9a2d7494f08671ca35b92c4c791c7049594ca7514197f
NEOTERM_PKG_DEPENDS="libc++"
NEOTERM_PKG_CONFLICTS="glslang, spirv-tools"
NEOTERM_PKG_NO_STATICSPLIT=true
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DSHADERC_SKIP_TESTS=ON
"

neoterm_step_post_get_source() {
	./utils/git-sync-deps
}
