NEOTERM_PKG_HOMEPAGE=https://aditya-k2.github.io/gomp/
NEOTERM_PKG_DESCRIPTION="MPD client inspired by ncmpcpp with builtin cover-art view and LastFM integration"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
_COMMIT=bc981b41e9499dd666d340e6bc20cc2f403e3871
NEOTERM_PKG_VERSION=2023.02.02
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=git+https://github.com/aditya-K2/gomp
NEOTERM_PKG_SHA256=0e6c00426b5952642527234726e3936d78b30b5f08962a2dddac945ca7f91001
NEOTERM_PKG_GIT_BRANCH=master
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_DEPENDS="mpd"

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

neoterm_step_make() {
	neoterm_setup_golang
	export GOFLAGS="-buildmode=pie -trimpath -mod=readonly -modcacherw"
	go build -o gomp
}

neoterm_step_make_install() {
	install -Dm700 gomp $NEOTERM_PREFIX/bin/
}
