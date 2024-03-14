NEOTERM_PKG_HOMEPAGE=https://github.com/keshavbhatt/olivia
NEOTERM_PKG_DESCRIPTION="Elegant music player for LINUX"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_LICENSE_FILE="../LICENSE"
NEOTERM_PKG_MAINTAINER="@neoterm"
_COMMIT=4048134f7df91dc9368147d9aac25f408d6ecb59
NEOTERM_PKG_VERSION=2022.10.20
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=git+https://github.com/keshavbhatt/olivia
NEOTERM_PKG_SHA256=71994c6c9821f7bdf3560c308e3b0b1b27799b497f0ca9cf93969fbf998289ea
NEOTERM_PKG_GIT_BRANCH=master
NEOTERM_PKG_DEPENDS="coreutils, libc++, mpv, python, qt5-qtbase, qt5-qtwebkit, socat, taglib, wget"
NEOTERM_PKG_BUILD_DEPENDS="qt5-qtbase-cross-tools"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
PREFIX=$NEOTERM_PREFIX
"

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
	NEOTERM_PKG_SRCDIR+="/src"
	NEOTERM_PKG_BUILDDIR="$NEOTERM_PKG_SRCDIR"
}

neoterm_step_configure() {
	"${NEOTERM_PREFIX}/opt/qt/cross/bin/qmake" \
		-spec "${NEOTERM_PREFIX}/lib/qt/mkspecs/neoterm-cross" \
		${NEOTERM_PKG_EXTRA_CONFIGURE_ARGS}
}
