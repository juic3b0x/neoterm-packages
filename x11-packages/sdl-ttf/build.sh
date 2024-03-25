NEOTERM_PKG_HOMEPAGE=https://www.libsdl.org/projects/SDL_ttf
NEOTERM_PKG_DESCRIPTION="A companion library to SDL for working with TrueType (tm) fonts"
NEOTERM_PKG_LICENSE="ZLIB"
NEOTERM_PKG_MAINTAINER="@Yonle"
_COMMIT=2648c22c4f9e32d05a11b32f636b1c225a1502ac
_COMMIT_DATE=20220526
NEOTERM_PKG_VERSION=2.0.11-p${_COMMIT_DATE}
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=git+https://github.com/libsdl-org/SDL_ttf
NEOTERM_PKG_SHA256=9e603ae3ee9363808e5eacf671f35ab92001ece21dc7d3eb1fb6209fa5c38ad4
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_GIT_BRANCH=SDL-1.2
NEOTERM_PKG_DEPENDS="freetype, sdl"

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

neoterm_step_pre_configure() {
	LDFLAGS+=" -lm"
}
