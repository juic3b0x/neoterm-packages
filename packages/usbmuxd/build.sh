NEOTERM_PKG_HOMEPAGE=https://libimobiledevice.org
NEOTERM_PKG_DESCRIPTION="A socket daemon to multiplex connections from and to iOS devices"
NEOTERM_PKG_LICENSE="GPL-2.0, GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
_COMMIT=049877e1f7a54f63fef12dd384c9a22fb38b3514
_COMMIT_DATE=20230421
NEOTERM_PKG_VERSION=1.1.1-p${_COMMIT_DATE}
NEOTERM_PKG_SRCURL=git+https://github.com/libimobiledevice/usbmuxd
NEOTERM_PKG_SHA256=4bf82bd3b7451139114ea0545e0d10f8d45fb813be008d91dad814d93f96b40c
NEOTERM_PKG_GIT_BRANCH=master
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_DEPENDS="libimobiledevice-glue, libplist, libusb"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--without-preflight
--without-systemd
"

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
