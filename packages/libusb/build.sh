NEOTERM_PKG_HOMEPAGE=https://libusb.info/
NEOTERM_PKG_DESCRIPTION="A C library that provides generic access to USB devices"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.0.27"
NEOTERM_PKG_SRCURL=https://github.com/libusb/libusb/releases/download/v${NEOTERM_PKG_VERSION}/libusb-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=ffaa41d741a8a3bee244ac8e54a72ea05bf2879663c098c82fc5757853441575
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BREAKS="libusb-dev"
NEOTERM_PKG_REPLACES="libusb-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--disable-udev"

neoterm_step_post_massage() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION_GUARD_FILES="lib/libusb-1.0.so"
	local f
	for f in ${_SOVERSION_GUARD_FILES}; do
		if [ ! -e "${f}" ]; then
			neoterm_error_exit "SOVERSION guard check failed."
		fi
	done
}
