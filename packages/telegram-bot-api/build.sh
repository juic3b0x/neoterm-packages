NEOTERM_PKG_HOMEPAGE=https://github.com/tdlib/telegram-bot-api
NEOTERM_PKG_DESCRIPTION="Telegram Bot API server"
NEOTERM_PKG_LICENSE="BSL-1.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_SRCURL=git+https://github.com/tdlib/telegram-bot-api
_COMMIT=ade0841d41b7126c2d908475291a5e1cd8a1b905
_COMMIT_DATE=2023.12.28
NEOTERM_PKG_VERSION=${_COMMIT_DATE//./}
NEOTERM_PKG_SHA256=0dc8d889a1bcb13fac85ef1cb65dc7cc93311e36ce21b6a032fbf4f810824730
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_GIT_BRANCH=master
NEOTERM_PKG_HOSTBUILD=true
NEOTERM_PKG_DEPENDS="libc++, openssl, zlib"

neoterm_step_get_source() {
	rm -rf $NEOTERM_PKG_SRCDIR
	mkdir -p $NEOTERM_PKG_SRCDIR
	cd $NEOTERM_PKG_SRCDIR
	git clone --depth 1 --branch ${NEOTERM_PKG_GIT_BRANCH} \
		${NEOTERM_PKG_SRCURL#git+} .
	git fetch --unshallow
	git checkout $_COMMIT
	git submodule update --init --recursive --depth=1
}

neoterm_step_post_get_source() {
	local version="$(git log -1 --format=%cs | sed 's/-//g')"
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

neoterm_step_host_build() {
	neoterm_setup_cmake
	cmake "-DCMAKE_BUILD_TYPE=Release" "$NEOTERM_PKG_SRCDIR"
	cmake --build . --target prepare_cross_compiling
}
