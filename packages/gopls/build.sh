NEOTERM_PKG_HOMEPAGE=https://github.com/golang/tools
NEOTERM_PKG_DESCRIPTION="The official Go language server"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@SunPodder"
NEOTERM_PKG_VERSION="0.15.2"
NEOTERM_PKG_SRCURL=https://github.com/golang/tools/archive/refs/tags/gopls/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=cf5b8246b36967eb8fbbed518ea941110cc6bbcc7f42a44bc5a4fe0d7ee61652
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"

neoterm_pkg_auto_update() {
	# Get the newest tag:
	local tag
	tag="$(neoterm_github_api_get_tag "${NEOTERM_PKG_SRCURL}" "${NEOTERM_PKG_UPDATE_TAG_TYPE}")"
	# check if this is not a release:
	if grep -qP "^gopls/v${NEOTERM_PKG_UPDATE_VERSION_REGEXP}\$" <<<"$tag"; then
		neoterm_pkg_upgrade_version "$tag"
	else
		echo "WARNING: Skipping auto-update: Not a release($tag)"
	fi
}

neoterm_step_make() {
	neoterm_setup_golang

	cd $NEOTERM_PKG_SRCDIR/gopls
	go build -o gopls
}

neoterm_step_make_install() {
	install -Dm755 -t $NEOTERM_PREFIX/bin $NEOTERM_PKG_SRCDIR/gopls/gopls
}

