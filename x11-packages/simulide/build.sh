NEOTERM_PKG_HOMEPAGE=https://github.com/SimulIDE/SimulIDE
NEOTERM_PKG_DESCRIPTION="Electronic Circuit Simulator Community Edition"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
_COMMIT=4bf26bc839147551a00938aa2949012681a3e046
NEOTERM_PKG_VERSION=2021.11.04
NEOTERM_PKG_SRCURL=git+https://github.com/SimulIDE/SimulIDE
NEOTERM_PKG_SHA256=253fb33e504d2735f425d2bcefed384c3d090feb413920735dbff0415d27620a
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_GIT_BRANCH=master
NEOTERM_PKG_DEPENDS="libc++, libelf, qt5-qtbase, qt5-qtmultimedia, qt5-qtscript, qt5-qtserialport, qt5-qtsvg"
NEOTERM_PKG_BUILD_DEPENDS="qt5-qtbase-cross-tools, qt5-qttools-cross-tools"
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
	export PATH=$NEOTERM_PREFIX/opt/qt/cross/bin:$PATH
}

neoterm_step_configure() {
	"${NEOTERM_PREFIX}/opt/qt/cross/bin/qmake" \
		-spec "${NEOTERM_PREFIX}/lib/qt/mkspecs/neoterm-cross" \
		${NEOTERM_PKG_EXTRA_CONFIGURE_ARGS}
}

neoterm_step_make_install() {
	cp -rT ./release/SimulIDE_* $NEOTERM_PREFIX
}
