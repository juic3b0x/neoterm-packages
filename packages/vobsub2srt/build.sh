NEOTERM_PKG_HOMEPAGE=https://github.com/ruediger/VobSub2SRT
NEOTERM_PKG_DESCRIPTION="A simple command line program to convert .idx / .sub subtitles into .srt text subtitles by using OCR"
NEOTERM_PKG_LICENSE="GPL-3.0, GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
_COMMIT=0ba6e25e078a040195d7295e860cc9064bef7c2c
NEOTERM_PKG_VERSION=2017.12.18
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=git+https://github.com/ruediger/VobSub2SRT
NEOTERM_PKG_SHA256=20cb64627124e4f22e44e5e48d00148683e0a9b6317f3d4d8783b689cd09a7f7
NEOTERM_PKG_GIT_BRANCH=master
NEOTERM_PKG_DEPENDS="libc++, tesseract"
NEOTERM_PKG_FORCE_CMAKE=true

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
