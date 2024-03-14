NEOTERM_PKG_HOMEPAGE=https://github.com/ajeetdsouza/clidle
NEOTERM_PKG_DESCRIPTION="Play Wordle over SSH"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
_COMMIT=fe27556c1147333af2cfe81cbc40f4f60ea191ee
NEOTERM_PKG_VERSION=2022.05.25
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=git+https://github.com/ajeetdsouza/clidle
NEOTERM_PKG_SHA256=68bec2f8445fe78d6295811d30adadc1aa16abce9911f65e619da67d75e3fdd5
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_GIT_BRANCH=main
NEOTERM_PKG_GROUPS="games"
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

neoterm_step_pre_configure() {
	neoterm_setup_golang

	go mod init || :
	go mod tidy
}

neoterm_step_make() {
	go build
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin clidle
}
