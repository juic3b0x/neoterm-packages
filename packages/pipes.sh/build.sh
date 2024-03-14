NEOTERM_PKG_HOMEPAGE=https://github.com/pipeseroni/pipes.sh
NEOTERM_PKG_DESCRIPTION="Animated pipes terminal screensaver"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@Efreak"
_COMMIT=581792d4e0ea51e15889ba14a85db1bc9727b83d
NEOTERM_PKG_VERSION=2018.04.22
NEOTERM_PKG_SRCURL=git+https://github.com/pipeseroni/pipes.sh
NEOTERM_PKG_SHA256=d28a4f49acf31fd5a2d18684d6b6f7a8fca735d98919149e32ce65598091a9b6
NEOTERM_PKG_GIT_BRANCH=master
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
	cd "$NEOTERM_PKG_SRCDIR"
	make install PREFIX=$NEOTERM_PREFIX
}
