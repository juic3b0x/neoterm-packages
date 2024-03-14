NEOTERM_PKG_HOMEPAGE=https://github.com/noncombatant/robotfindskitten
NEOTERM_PKG_DESCRIPTION="A very fun adventure game for robots and humans"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
_COMMIT=58155f8d3459e30ad393e2d7c23ad0c8eeb96df2
NEOTERM_PKG_VERSION=2022.05.21
NEOTERM_PKG_SRCURL=git+https://github.com/noncombatant/robotfindskitten
NEOTERM_PKG_SHA256=58d9403ba1d3303b68a8fe82357d2c5ca69bf45c032670bf9b28d8c4a149496d
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_GIT_BRANCH=main
NEOTERM_PKG_DEPENDS="ncurses"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="-e"
NEOTERM_PKG_GROUPS="games"

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
	LDFLAGS+=" -lncursesw"
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin robotfindskitten
}
