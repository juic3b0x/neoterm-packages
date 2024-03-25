NEOTERM_PKG_HOMEPAGE=https://upscaledb.com/
NEOTERM_PKG_DESCRIPTION="A database engine written in C/C++"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
_COMMIT=cb124e1f91601872a7b3bd4da10e5fa97a8da86b
_COMMIT_DATE=2021.08.20
NEOTERM_PKG_VERSION=2.2.1p${_COMMIT_DATE//./}
NEOTERM_PKG_REVISION=9
NEOTERM_PKG_SRCURL=git+https://github.com/cruppstahl/upscaledb
NEOTERM_PKG_SHA256=83e26f9f099897f347129470b494487bddf96c3d09ab4747251135d47d8b4256
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_GIT_BRANCH=master
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_DEPENDS="boost, libc++, libsnappy, openssl, zlib"
NEOTERM_PKG_BUILD_DEPENDS="boost-headers"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-simd
--disable-java
--disable-remote
--with-boost=$NEOTERM_PREFIX
--without-tcmalloc
--without-berkeleydb
"

neoterm_step_post_get_source() {
	git fetch --unshallow
	git checkout $_COMMIT

	local version="$(git log -1 --format=%cs | sed 's/-/./g')"
	if [ "$version" != "$_COMMIT_DATE" ]; then
		echo -n "ERROR: The specified commit date \"$_COMMIT_DATE\""
		echo " is different from what is expected to be: \"$version\""
		return 1
	fi

	local s=$(find . -type f ! -path '*/.git/*' -print0 | xargs -0 sha256sum | LC_ALL=C sort | sha256sum)
	if [[ "${s}" != "${NEOTERM_PKG_SHA256}  "* ]]; then
		neoterm_error_exit "Checksum mismatch for source files."
	fi
}

neoterm_step_pre_configure() {
	sh bootstrap.sh

	CPPFLAGS+=" -DBOOST_TIMER_ENABLE_DEPRECATED"
	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
