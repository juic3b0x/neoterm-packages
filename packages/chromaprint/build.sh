NEOTERM_PKG_HOMEPAGE=https://acoustid.org/chromaprint
NEOTERM_PKG_DESCRIPTION="C library for generating audio fingerprints used by AcoustID"
NEOTERM_PKG_LICENSE="LGPL-2.1, MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
_COMMIT=aa67c95b9e486884a6d3ee8b0c91207d8c2b0551
_COMMIT_DATE=20221217
NEOTERM_PKG_VERSION=1.5.1-p${_COMMIT_DATE}
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=git+https://github.com/acoustid/chromaprint
NEOTERM_PKG_SHA256=5a880f6e976fdbbfbc1d5487d27cf59fba7398c675c6cb5069aaf3d3cff716a7
NEOTERM_PKG_GIT_BRANCH=master
NEOTERM_PKG_DEPENDS="ffmpeg, libc++"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_BUILD_TYPE=Release
-DBUILD_SHARED_LIBS=ON
-DBUILD_TOOLS=ON
-DBUILD_TESTS=OFF
"

neoterm_step_post_get_source() {
	git fetch --unshallow
	git checkout $_COMMIT

	local pdate="p$(git log -1 --format=%cs | sed 's/-//g')"
	if [[ "$NEOTERM_PKG_VERSION" != *"${pdate}" ]]; then
		echo -n "ERROR: The version string \"$NEOTERM_PKG_VERSION\" is"
		echo -n " different from what is expected to be; should end"
		echo " with \"${pdate}\"."
		return 1
	fi

	local s=$(find . -type f ! -path '*/.git/*' -print0 | xargs -0 sha256sum | LC_ALL=C sort | sha256sum)
	if [[ "${s}" != "${NEOTERM_PKG_SHA256}  "* ]]; then
		neoterm_error_exit "Checksum mismatch for source files."
	fi
}
