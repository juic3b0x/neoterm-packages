NEOTERM_PKG_HOMEPAGE=https://github.com/OpenZWave/open-zwave
NEOTERM_PKG_DESCRIPTION="A C++ library to control Z-Wave Networks via a USB Z-Wave Controller"
NEOTERM_PKG_LICENSE="LGPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
_COMMIT=3fff11d246a0d558d26110e1db6bd634a1b347c0
_COMMIT_DATE=20221117
NEOTERM_PKG_VERSION=1.6-p${_COMMIT_DATE}
NEOTERM_PKG_SRCURL=git+https://github.com/OpenZWave/open-zwave
NEOTERM_PKG_SHA256=d1077d3cf7fae3b61de5789321561b17a2bae4705d3016273d65785683bfc062
NEOTERM_PKG_GIT_BRANCH=master
NEOTERM_PKG_DEPENDS="libc++"
# XXX: libusb is not linked against (unexpectedly?)
NEOTERM_PKG_BUILD_DEPENDS="libusb"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_post_get_source() {
	git fetch --unshallow
	git checkout $_COMMIT

	local pdate="p$(git log -1 --format=%cs | sed 's/-//g')"
	if [[ "$NEOTERM_PKG_VERSION" != *"${pdate}" ]]; then
		echo -n "ERROR: The version string \"$NEOTERM_PKG_VERSION\" is"
		echo -n " different from what is expected to be; should end"
		echo " with \"${pdate}\"."
		return 1
	fi

	local s=$(find . -type f ! -path '*/.git/*' -print0 | xargs -0 sha256sum | LC_ALL=C sort | sha256sum)
	if [[ "${s}" != "${NEOTERM_PKG_SHA256}  "* ]]; then
		neoterm_error_exit "Checksum mismatch for source files."
	fi
}

neoterm_step_pre_configure() {
	export pkgconfigdir=$NEOTERM_PREFIX/lib/pkgconfig

	CPPFLAGS+=" -Wno-error=inconsistent-missing-override"
}
