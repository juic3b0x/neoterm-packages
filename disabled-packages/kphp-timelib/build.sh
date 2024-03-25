NEOTERM_PKG_HOMEPAGE=https://github.com/derickr/timelib
NEOTERM_PKG_DESCRIPTION="timelib 2020.02 library fork for KPHP"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_LICENSE_FILE="LICENSE.rst"
NEOTERM_PKG_MAINTAINER="@neoterm"
_COMMIT=59ee82faa8d9ed42b1b9b9339e0b989cc929cd4a
NEOTERM_PKG_VERSION=2021.03.01
NEOTERM_PKG_SRCURL=git+https://github.com/VKCOM/timelib
NEOTERM_PKG_GIT_BRANCH=master
NEOTERM_PKG_NO_STATICSPLIT=true

neoterm_step_post_get_source() {
	git fetch --unshallow
	git checkout $_COMMIT

	local version="$(git log -1 --format=%cs | sed 's/-/./g')"
	if [ "$version" != "$NEOTERM_PKG_VERSION" ]; then
		echo -n "ERROR: The specified version \"$NEOTERM_PKG_VERSION\""
		echo " is different from what is expected to be: \"$version\""
		return 1
	fi
}
