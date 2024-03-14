NEOTERM_PKG_HOMEPAGE=https://libimobiledevice.org
NEOTERM_PKG_DESCRIPTION="A client library for applications to handle usbmux protocol connections with iOS devices"
NEOTERM_PKG_LICENSE="LGPL-2.1, GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
_COMMIT=f47c36f5bd2a653a3bd7fb1cf1d2c50b0e6193fb
_COMMIT_DATE=20230430
NEOTERM_PKG_VERSION=2.0.2-p${_COMMIT_DATE}
NEOTERM_PKG_SRCURL=git+https://github.com/libimobiledevice/libusbmuxd
NEOTERM_PKG_SHA256=c415b8859ccae494387c14dc9c297910843b16b5ba62aab15d51116137b513c4
NEOTERM_PKG_GIT_BRANCH=master
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_DEPENDS="libimobiledevice-glue, libplist, libusb, usbmuxd"
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

	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=6

	local e=$(sed -En 's/LIBUSBMUXD_SO_VERSION="?([0-9]+):([0-9]+):([0-9]+).*/\1-\3/p' \
				configure.ac)
	if [ ! "${e}" ] || [ "${_SOVERSION}" != "$(( "${e}" ))" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}

neoterm_step_pre_configure() {
	autoreconf -fi
}

neoterm_step_post_massage() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION_GUARD_FILES="lib/libusbmuxd-2.0.so"
	local f
	for f in ${_SOVERSION_GUARD_FILES}; do
		if [ ! -e "${f}" ]; then
			neoterm_error_exit "SOVERSION guard check failed."
		fi
	done
}
