NEOTERM_PKG_HOMEPAGE=https://gitlab.com/berdyansk/astra-sm
NEOTERM_PKG_DESCRIPTION="Software for digital TV broadcasting"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
_COMMIT=44bcd2852b7f315233267f639730e0e21b9b6c22
NEOTERM_PKG_VERSION=2019.06.19
NEOTERM_PKG_SRCURL=git+https://github.com/OpenVisionE2/astra-sm
NEOTERM_PKG_SHA256=635bcda7c024adee99c540bcae10cba16946c54108817ac2f3a6f36305b29e85
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_METHOD=repology
NEOTERM_PKG_GIT_BRANCH=staging
NEOTERM_PKG_DEPENDS="libdvbcsa, liblua53"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--with-lua-includes=$NEOTERM_PREFIX/include/lua5.3
--with-lua-libs=$NEOTERM_PREFIX/lib/liblua5.3.so
--with-lua-compiler=no
--with-ffmpeg=no
--with-libcrypto=no
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
