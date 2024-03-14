NEOTERM_PKG_HOMEPAGE=http://caca.zoy.org/wiki/zzuf
NEOTERM_PKG_DESCRIPTION="A transparent application input fuzzer"
NEOTERM_PKG_LICENSE="WTFPL"
NEOTERM_PKG_MAINTAINER="@neoterm"
_COMMIT=a7111e51eac3086264fcca0c7026de22b5ab55c7
NEOTERM_PKG_VERSION=2022.05.29
NEOTERM_PKG_SRCURL=git+https://github.com/samhocevar/zzuf
NEOTERM_PKG_SHA256=a49c6704adf58d39d90fd27503d5b9748a7481ba70d92a0f4b8f9c480e9fd6ce
NEOTERM_PKG_GIT_BRANCH=master

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

	CPPFLAGS+=" -D__USE_GNU"
}
