NEOTERM_PKG_HOMEPAGE=https://www.libsdl.org/projects/SDL_net/
NEOTERM_PKG_DESCRIPTION="A small sample cross-platform networking library"
NEOTERM_PKG_LICENSE="ZLIB"
NEOTERM_PKG_MAINTAINER="@neoterm"
_COMMIT=3079ee39e1224d744fdedc066280690c8ec40bb1
_COMMIT_DATE=20221115
NEOTERM_PKG_VERSION=1.2.8-p${_COMMIT_DATE}
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=git+https://github.com/libsdl-org/SDL_net
NEOTERM_PKG_SHA256=9e48bf33b6702b9a570cc8819b69d2aec0d5cfbf410f0ac4ede8e189e216023f
NEOTERM_PKG_GIT_BRANCH=SDL-1.2
NEOTERM_PKG_DEPENDS="sdl"
NEOTERM_PKG_CONFLICTS="libsdl-net"
NEOTERM_PKG_REPLACES="libsdl-net"

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
