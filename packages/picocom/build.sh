NEOTERM_PKG_HOMEPAGE=https://github.com/npat-efault/picocom
NEOTERM_PKG_DESCRIPTION="A minimal dumb-terminal emulation program"
# "BSD 2-Clause" applies to bundled Linenoise library
NEOTERM_PKG_LICENSE="GPL-2.0, BSD 2-Clause"
NEOTERM_PKG_LICENSE_FILE="LICENSE.txt, linenoise-1.0/LICENSE"
NEOTERM_PKG_MAINTAINER="@neoterm"
_COMMIT=1acf1ddabaf3576b4023c4f6f09c5a3e4b086fb8
NEOTERM_PKG_VERSION=2018.04.12
NEOTERM_PKG_SRCURL=git+https://github.com/npat-efault/picocom
NEOTERM_PKG_SHA256=51340c2f57638117e1ddb40a29d6acc8692df07ce44bf9cc8fa70417847bb1a7
NEOTERM_PKG_GIT_BRANCH=master
NEOTERM_PKG_BUILD_IN_SRC=true

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

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin pcasc pc{x,y,z}m picocom
	install -Dm600 -t $NEOTERM_PREFIX/share/man/man1 picocom.1
}
