NEOTERM_PKG_HOMEPAGE=https://www.libsdl.org/projects/SDL_image/
NEOTERM_PKG_DESCRIPTION="A simple library to load images of various formats as SDL surfaces"
NEOTERM_PKG_LICENSE="ZLIB"
NEOTERM_PKG_MAINTAINER="@neoterm"
_COMMIT=9a5bd2d522c8e0f5a92ba7c8c1bac123228611d0
_COMMIT_DATE=20230130
NEOTERM_PKG_VERSION=1.2.12-p${_COMMIT_DATE}
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=git+https://github.com/libsdl-org/SDL_image
NEOTERM_PKG_SHA256=9b1cbb2fa68632242d49841a9341af1b432e4f8129d3c91b90420b486f5dd158
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_GIT_BRANCH=SDL-1.2
NEOTERM_PKG_DEPENDS="libjpeg-turbo, libpng, libtiff, libwebp, sdl"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-jpg-shared
--disable-png-shared
--disable-tif-shared
--disable-webp-shared
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
