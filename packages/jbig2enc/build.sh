NEOTERM_PKG_HOMEPAGE=https://github.com/agl/jbig2enc
NEOTERM_PKG_DESCRIPTION="An encoder for JBIG2"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
_COMMIT=ea050190466f5336c69c6a11baa1cb686677fcab
NEOTERM_PKG_VERSION=2023.01.08
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=git+https://github.com/agl/jbig2enc
NEOTERM_PKG_SHA256=cb098a85a236c930588c20138d2720636f914e98b6d9211261f78afb3eea2506
NEOTERM_PKG_GIT_BRANCH=master
NEOTERM_PKG_DEPENDS="giflib, leptonica, libc++, libjpeg-turbo, libpng, libtiff, libwebp, python, zlib"

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
	sh autogen.sh

	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
