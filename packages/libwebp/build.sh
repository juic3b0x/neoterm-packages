NEOTERM_PKG_HOMEPAGE=https://github.com/webmproject/libwebp
NEOTERM_PKG_DESCRIPTION="Library to encode and decode images in WebP format"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.3.2
NEOTERM_PKG_SRCURL=https://github.com/webmproject/libwebp/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=c2c2f521fa468e3c5949ab698c2da410f5dce1c5e99f5ad9e70e0e8446b86505
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_DEPENDS="giflib, libjpeg-turbo, libpng, libtiff"
NEOTERM_PKG_BREAKS="libwebp-dev"
NEOTERM_PKG_REPLACES="libwebp-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--enable-libwebpmux
--enable-libwebpdemux
--enable-libwebpdecoder
--enable-libwebpextras
--enable-swap-16bit-csp
--enable-gif
--enable-jpeg
--enable-png
--enable-tiff
--disable-wic
"
NEOTERM_PKG_RM_AFTER_INSTALL="share/man/man1"

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=7

	local e=$(sed -En 's/^libwebp_la_LDFLAGS\s*=.*\s+-version-info\s+([0-9]+):([0-9]+):([0-9]+).*/\1-\3/p' \
			src/Makefile.am)
	if [ ! "${e}" ] || [ "${_SOVERSION}" != "$(( "${e}" ))" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}

neoterm_step_pre_configure() {
	./autogen.sh
}
