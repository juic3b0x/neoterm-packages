NEOTERM_PKG_HOMEPAGE=https://github.com/tome2/tome2
NEOTERM_PKG_DESCRIPTION="An open world roguelike adventure set in middle earth"
NEOTERM_PKG_LICENSE="non-free"
NEOTERM_PKG_MAINTAINER="@neoterm"
_COMMIT=1e26568b084104edd2a696e86118a3e71c78d61e
NEOTERM_PKG_VERSION=2022.12.27
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=git+https://github.com/tome2/tome2
NEOTERM_PKG_SHA256=e18ab63c74f8650b8348cbc82af923e44a42f2d4a2621f993ee7e789f461a61a
NEOTERM_PKG_GIT_BRANCH=master
NEOTERM_PKG_DEPENDS="boost, libc++, libx11, ncurses"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="-DSYSTEM_INSTALL=YES"

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

neoterm_step_install_license() {
	install -Dm600 $NEOTERM_PKG_BUILDER_DIR/LICENSE \
		$NEOTERM_PREFIX/share/doc/$NEOTERM_PKG_NAME/LICENSE
}
