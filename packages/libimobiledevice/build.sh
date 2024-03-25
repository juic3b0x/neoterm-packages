NEOTERM_PKG_HOMEPAGE=https://libimobiledevice.org/
NEOTERM_PKG_DESCRIPTION="A library to communicate with services on iOS devices using native protocols"
# License: LGPL-2.1-or-later
NEOTERM_PKG_LICENSE="LGPL-2.1"
_COMMIT=860ffb707af3af94467d2ece4ad258dda957c6cd
_COMMIT_DATE=20230430
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.3.0-p${_COMMIT_DATE}
NEOTERM_PKG_SRCURL=git+https://github.com/libimobiledevice/libimobiledevice
NEOTERM_PKG_SHA256=5b88f3b348f06fe9d1b5ffc639f813b5956d757e527d5c7ca724a64c1b0b3b4e
NEOTERM_PKG_GIT_BRANCH=master
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_DEPENDS="libimobiledevice-glue, libplist, libusbmuxd, openssl, usbmuxd"

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
	autoreconf -fi
}
