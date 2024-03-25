NEOTERM_PKG_HOMEPAGE=https://ukoethe.github.io/vigra/
NEOTERM_PKG_DESCRIPTION="Computer vision library"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.11.2"
NEOTERM_PKG_SRCURL=https://github.com/ukoethe/vigra/archive/refs/tags/Version-${NEOTERM_PKG_VERSION//./-}.tar.gz
NEOTERM_PKG_SHA256=4841936f5c3c137611ec782e293d961df29d3b5b70ade8cb711374de0f4cb5d3
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="imath, libc++, libhdf5, libjpeg-turbo, libpng, libtiff, openexr, zlib"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DRUN_RESULT=0
-DRUN_RESULT__TRYRUN_OUTPUT=201103
-DWITH_OPENEXR=ON
"
NEOTERM_PKG_RM_AFTER_INSTALL="doc"

neoterm_pkg_auto_update() {
	local latest_tag="$(neoterm_github_api_get_tag "${NEOTERM_PKG_SRCURL}")"
	[[ -z "${latest_tag}" ]] && neoterm_error_exit "ERROR: Unable to get tag from ${NEOTERM_PKG_SRCURL}"
	neoterm_pkg_upgrade_version "$(sed 's/Version-\([0-9]\+\)-\([0-9]\+\)-\([0-9]\+\)/\1.\2.\3/' <<< ${latest_tag})"
}
