NEOTERM_PKG_HOMEPAGE=https://github.com/rui314/chibicc
NEOTERM_PKG_DESCRIPTION="A Small C Compiler"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
_COMMIT=90d1f7f199cc55b13c7fdb5839d1409806633fdb
NEOTERM_PKG_VERSION=2020.12.07
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=git+https://github.com/rui314/chibicc
NEOTERM_PKG_SHA256=9cb136d4713c8003122e8b637730a15808dd102dc2b54a5f96f33053a34a8171
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_GIT_BRANCH=main
NEOTERM_PKG_DEPENDS="binutils-is-llvm | binutils, libandroid-glob"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_BLACKLISTED_ARCHES="aarch64, arm, i686"

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

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin chibicc
}
