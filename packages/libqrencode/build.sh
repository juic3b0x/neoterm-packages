NEOTERM_PKG_HOMEPAGE=https://fukuchi.org/works/qrencode/
NEOTERM_PKG_DESCRIPTION="Fast and compact library for encoding data in a QR Code symbol"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="Henrik Grimler @Grimler91"
NEOTERM_PKG_VERSION=4.1.1
NEOTERM_PKG_SRCURL=https://github.com/fukuchi/libqrencode/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=5385bc1b8c2f20f3b91d258bf8ccc8cf62023935df2d2676b5b67049f31a049c
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libandroid-support, libpng, zlib"
NEOTERM_PKG_BREAKS="libqrencode-dev"
NEOTERM_PKG_REPLACES="libqrencode-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="-DBUILD_SHARED_LIBS=ON"

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=4

	local v=$(echo ${NEOTERM_PKG_VERSION#*:} | cut -d . -f 1)
	if [ "${v}" != "${_SOVERSION}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}
