NEOTERM_PKG_HOMEPAGE=https://phantomjs.org/
NEOTERM_PKG_DESCRIPTION="A headless WebKit scriptable with JavaScript"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_LICENSE_FILE="LICENSE.BSD"
NEOTERM_PKG_MAINTAINER="@neoterm"
_COMMIT=0a0b0facb16acfbabb7804822ecaf4f4b9dce3d2
NEOTERM_PKG_VERSION=2020.07.13
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=git+https://github.com/ariya/phantomjs
NEOTERM_PKG_SHA256=5603bfc300c6bf712db3d8e7dea6b0f8d97eb470b8ab589e9cec3b290ed56d57
NEOTERM_PKG_GIT_BRANCH=master
NEOTERM_PKG_DEPENDS="libc++, qt5-qtbase, qt5-qtwebkit"
NEOTERM_PKG_BUILD_DEPENDS="qt5-qtbase-cross-tools"
NEOTERM_PKG_FORCE_CMAKE=true

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
