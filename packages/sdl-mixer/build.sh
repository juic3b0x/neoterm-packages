NEOTERM_PKG_HOMEPAGE=https://www.libsdl.org/projects/SDL_mixer/release-1.2.html
NEOTERM_PKG_DESCRIPTION="A simple multi-channel audio mixer"
NEOTERM_PKG_LICENSE="ZLIB"
NEOTERM_PKG_MAINTAINER="@neoterm"
_COMMIT=7804621c533dddfe970e97c94c4ea72d48ed7f48
_COMMIT_DATE=20221010
NEOTERM_PKG_VERSION=1.2.12-p${_COMMIT_DATE}
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=git+https://github.com/libsdl-org/SDL_mixer
NEOTERM_PKG_SHA256=473a39b04f1a2ec29a22e3eafaafeee9704129f117044d17c591646648b540cd
NEOTERM_PKG_GIT_BRANCH=SDL-1.2
NEOTERM_PKG_DEPENDS="libflac, libvorbis, sdl"

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
