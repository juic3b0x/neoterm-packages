NEOTERM_PKG_HOMEPAGE=https://github.com/magiblot/tvision
NEOTERM_PKG_DESCRIPTION="A modern port of Turbo Vision 2.0 with Unicode support"
NEOTERM_PKG_LICENSE="Public Domain, MIT"
NEOTERM_PKG_LICENSE_FILE="COPYRIGHT"
NEOTERM_PKG_MAINTAINER="@neoterm"
_COMMIT=115924552b4ab8030543ce14e64475f44c758457
NEOTERM_PKG_VERSION=2023.01.29
NEOTERM_PKG_SRCURL=git+https://github.com/magiblot/tvision
NEOTERM_PKG_SHA256=4e80413e75820962c42da49e22aad97b949f8b729a28d4562d4e3148f5b072f5
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_GIT_BRANCH=master
NEOTERM_PKG_DEPENDS="libc++, ncurses"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DTV_BUILD_EXAMPLES=OFF
-DTV_BUILD_USING_GPM=OFF
-DTV_OPTIMIZE_BUILD=OFF
"

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
