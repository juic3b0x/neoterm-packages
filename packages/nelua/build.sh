NEOTERM_PKG_HOMEPAGE=https://nelua.io
NEOTERM_PKG_DESCRIPTION="Minimal, efficient, statically-typed and meta-programmable systems programming language"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
_COMMIT=112409b9b54468275a4f4700f04e1b03966994bb
NEOTERM_PKG_VERSION=2022.07.21
NEOTERM_PKG_SRCURL=git+https://github.com/edubart/nelua-lang
NEOTERM_PKG_SHA256=cc9e7d373cb260942ed304e2233cc7926ddef497489c54d36ac234770ff550d9
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_GIT_BRANCH="master"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_DEPENDS="build-essential, gdb, git"
NEOTERM_PKG_SUGGESTS="sdl2"

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
