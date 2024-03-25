NEOTERM_PKG_HOMEPAGE=https://github.com/lxml/lxml
NEOTERM_PKG_DESCRIPTION="A straightforward binding of libsass for Python"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=5.1.0
NEOTERM_PKG_SRCURL=https://github.com/lxml/lxml/releases/download/lxml-$NEOTERM_PKG_VERSION/lxml-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=c4b12bc6d6186ba8ac07bb7bb558312ec6738ca7d9365e862aa9c4462388ffb7
NEOTERM_PKG_DEPENDS="libxml2, libxslt, python, python-pip"
NEOTERM_PKG_PYTHON_COMMON_DEPS="wheel"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
NEOTERM_PKG_UPDATE_TAG_TYPE="latest-release-tag"

neoterm_pkg_auto_update() {
	local tag="$(neoterm_github_api_get_tag "${NEOTERM_PKG_SRCURL}" "${NEOTERM_PKG_UPDATE_TAG_TYPE}")"
	if grep -qP "^lxml-${NEOTERM_PKG_UPDATE_VERSION_REGEXP}\$" <<<"$tag"; then
		neoterm_pkg_upgrade_version "$tag"
	else
		echo "WARNING: Skipping auto-update: Not stable release($tag)"
	fi
}
