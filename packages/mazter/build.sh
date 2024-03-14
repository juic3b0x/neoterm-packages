NEOTERM_PKG_HOMEPAGE="https://github.com/Canop/mazter"
NEOTERM_PKG_DESCRIPTION="Mazes in your terminal"
NEOTERM_PKG_GROUPS="games"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_LICENSE_FILE="LICENSE"
NEOTERM_PKG_MAINTAINER="@neoterm"
_COMMIT=a02de683f93a61690d1a4f3b845f654f5e026484
NEOTERM_PKG_VERSION=2022.08.13
NEOTERM_PKG_SRCURL="git+https://github.com/Canop/mazter"
NEOTERM_PKG_SHA256=1196209325408a2335d989e056893c02cea48fcf0da8eacac264679b5f7304cb
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_GIT_BRANCH=main
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_post_get_source() {
	git fetch --unshallow
	git checkout $_COMMIT

	local version="$(git log -1 --format=%cs | sed 's/-/./g')"
	if [ "$version" != "$NEOTERM_PKG_VERSION" ]; then
		echo -n "ERROR: The specified version \"$NEOTERM_PKG_VERSION\""
		echo " is different from what is expected to be: \"$version\""
		return 1
	fi

	local s=$(find . -type f ! -path '*/.git/*' -print0 | xargs -0 sha256sum | LC_ALL=C sort | sha256sum)
	if [[ "${s}" != "${NEOTERM_PKG_SHA256}  "* ]]; then
		neoterm_error_exit "Checksum mismatch for source files."
	fi
}
