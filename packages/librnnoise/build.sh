NEOTERM_PKG_HOMEPAGE=https://jmvalin.ca/demo/rnnoise/
NEOTERM_PKG_DESCRIPTION="RNN-based noise suppression"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
_COMMIT=7f449bf8bd3b933891d12c30112268c4090e4d59
NEOTERM_PKG_VERSION=2021.03.12
NEOTERM_PKG_SRCURL=git+https://gitlab.xiph.org/xiph/rnnoise
NEOTERM_PKG_SHA256=e78ca58aeed18f0f7558bbb18f517326e4216a1f8aceb0d88dc4f77ca38cfd9d
NEOTERM_PKG_GIT_BRANCH=master
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-examples
--disable-doc
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

neoterm_step_pre_configure() {
	autoreconf -fi
}
