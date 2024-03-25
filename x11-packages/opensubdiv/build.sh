NEOTERM_PKG_HOMEPAGE=https://graphics.pixar.com/opensubdiv/docs/intro.html
NEOTERM_PKG_DESCRIPTION="A set of open source libraries that implement high performance subdivision surface (subdiv) evaluation"
# License: Modified Apache 2.0 License
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="LICENSE.txt, NOTICE.txt"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="3.6.0"
NEOTERM_PKG_SRCURL=https://github.com/PixarAnimationStudios/OpenSubdiv/archive/refs/tags/v${NEOTERM_PKG_VERSION//./_}.tar.gz
NEOTERM_PKG_SHA256=bebfd61ab6657a4f4ff27845fb66a167d00395783bfbd253254d87447ed1d879
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+_\d+_\d+"
NEOTERM_PKG_DEPENDS="libc++, libtbb, opengl"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DNO_EXAMPLES=ON
-DNO_TUTORIALS=ON
-DNO_PTEX=ON
-DNO_DOC=ON
-DNO_CUDA=ON
-DNO_OPENCL=ON
-DNO_TESTS=ON
-DNO_GLFW=ON
"

neoterm_pkg_auto_update() {
	# Get latest release tag:
	local tag="$(neoterm_github_api_get_tag "${NEOTERM_PKG_SRCURL}" newest-tag)"
	if grep -qP "^${NEOTERM_PKG_UPDATE_VERSION_REGEXP}\$" <<<"$tag"; then
		neoterm_pkg_upgrade_version "$tag"
	else
		echo "WARNING: Skipping auto-update: Not a release ($tag)"
	fi
}
