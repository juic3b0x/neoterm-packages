NEOTERM_PKG_HOMEPAGE=https://git.sr.ht/~ghost08/ratt
NEOTERM_PKG_DESCRIPTION="A tool for converting websites to rss/atom feeds"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
_COMMIT=ed1a675685b9d86d6602e168199ba9b4260f5f06
NEOTERM_PKG_VERSION=2023.02.02
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=git+https://git.sr.ht/~ghost08/ratt
NEOTERM_PKG_SHA256=cc9f7f63e18db9b1850f2de5a5309072c09735a551dda8363b6026cd8adfba50
NEOTERM_PKG_GIT_BRANCH=master
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="PREFIX=$NEOTERM_PREFIX"

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

neoterm_step_pre_configure() {
	neoterm_setup_golang

	go mod init || :
	go mod tidy
}
