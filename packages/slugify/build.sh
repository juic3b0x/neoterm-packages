NEOTERM_PKG_HOMEPAGE=https://github.com/benlinton/slugify
NEOTERM_PKG_DESCRIPTION="Bash command that converts filenames and directories to a web friendly format"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
_COMMIT=4528e8ecc2de14f76dfc76d045635beed138fb39
NEOTERM_PKG_VERSION=2016.01.23
NEOTERM_PKG_SRCURL=git+https://github.com/benlinton/slugify
NEOTERM_PKG_SHA256=f629ae6fb1ed2b3e51497502528996e36c135cfc81a8fc659fdc4ab73a6a4077
NEOTERM_PKG_GIT_BRANCH=master
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_DEPENDS=bash
NEOTERM_PKG_PLATFORM_INDEPENDENT=true

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

neoterm_step_make_install() {
	install -D slugify -t "$NEOTERM_PREFIX/bin"
	install -D slugify.1 -t "$NEOTERM_PREFIX/share/man/man1"
}
