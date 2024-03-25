NEOTERM_PKG_HOMEPAGE=https://github.com/gogakoreli/snake
NEOTERM_PKG_DESCRIPTION="Eat as much as you want while avoiding walls"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="Tipz Team @TipzTeam"
_COMMIT=a57f7f8aa8c77fcce2dabafca1a5ec4b96825231
NEOTERM_PKG_VERSION=2022.11.07
NEOTERM_PKG_SRCURL=git+https://github.com/gogakoreli/snake
NEOTERM_PKG_SHA256=3fc981af52289eaac169944de362e20d4fe6260a41158f5a8a44741e1522b89b
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_GIT_BRANCH=master
NEOTERM_PKG_DEPENDS="libc++"
NEOTERM_PKG_BUILD_IN_SRC=true
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

neoterm_step_make_install() {
	install -Dm755 -t $NEOTERM_PREFIX/bin/ snake
}

neoterm_step_install_license() {
	install -Dm644 -t $NEOTERM_PREFIX/share/doc/$NEOTERM_PKG_NAME/ \
		$NEOTERM_PKG_BUILDER_DIR/LICENSE
}
