NEOTERM_PKG_HOMEPAGE=https://github.com/vgmrips/vgmtools
NEOTERM_PKG_DESCRIPTION="A collection of tools for the VGM file format"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
_COMMIT=fc55484b5902191e5467e6044bb90c1c74a0c938
NEOTERM_PKG_VERSION=2023.01.27
NEOTERM_PKG_SRCURL=git+https://github.com/vgmrips/vgmtools
NEOTERM_PKG_SHA256=490b7e0f1dd3f58dc8ca501fa6cfd47ea65dde110023dcb16b25c7760e92851c
NEOTERM_PKG_GIT_BRANCH=master
NEOTERM_PKG_DEPENDS="libandroid-glob, libc++, zlib"

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
	LDFLAGS+=" -landroid-glob"
}
