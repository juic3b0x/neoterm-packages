NEOTERM_PKG_HOMEPAGE=https://github.com/mevdschee/2048.c
NEOTERM_PKG_DESCRIPTION="Console version of the game '2048' for GNU/Linux"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
_COMMIT=6c04517bb59c28f3831585da338f021bc2ea86d6
NEOTERM_PKG_VERSION=2022.10.23
NEOTERM_PKG_SRCURL=git+https://github.com/mevdschee/2048.c
NEOTERM_PKG_SHA256=ffa0f524a6c05f42613101e8b0c5881b489631d343ac1a5f615cc746fc34a857
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_METHOD=repology
NEOTERM_PKG_GIT_BRANCH=main
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_GROUPS="games"

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
