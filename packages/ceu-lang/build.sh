NEOTERM_PKG_HOMEPAGE="https://github.com/ceu-lang/ceu"
NEOTERM_PKG_DESCRIPTION="The Structured Synchronous Reactive Programming Language Céu"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_SRCURL="git+https://github.com/ceu-lang/ceu"
NEOTERM_PKG_GIT_BRANCH="master"
_COMMIT="5e0c8d3004ad98658ffe82823ad8303a8d371064"
NEOTERM_PKG_VERSION="2019.07.17"
NEOTERM_PKG_SHA256=bc3417d7a2a568d33ea01097bdfab6d34bb89da4b6191c169140a21cfefa5301
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_BUILD_DEPENDS="lua53, lua-lpeg"
NEOTERM_PKG_DEPENDS="lua53, lua-lpeg, liblua53"

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
