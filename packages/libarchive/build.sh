NEOTERM_PKG_HOMEPAGE=https://www.libarchive.org/
NEOTERM_PKG_DESCRIPTION="Multi-format archive and compression library"
NEOTERM_PKG_LICENSE="BSD 2-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="3.7.2"
NEOTERM_PKG_SRCURL=https://github.com/libarchive/libarchive/releases/download/v$NEOTERM_PKG_VERSION/libarchive-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=df404eb7222cf30b4f8f93828677890a2986b66ff8bf39dac32a804e96ddf104
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libbz2, libiconv, liblzma, libxml2, openssl, zlib"
NEOTERM_PKG_BREAKS="libarchive-dev"
NEOTERM_PKG_REPLACES="libarchive-dev"

# --without-nettle to use openssl instead:
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--without-nettle
--without-lz4
--without-zstd
--disable-acl
--disable-xattr
"

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=13

	local v=$(sed -En 's/^ARCHIVE_INTERFACE=`echo \$\(\(([0-9]+).*/\1/p' \
			configure.ac)
	if [ "${v}" != "${_SOVERSION}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}

neoterm_step_post_make_install() {
	# https://github.com/libarchive/libarchive/issues/1766
	sed -i '/^Requires\.private:/s/ iconv//' \
		$NEOTERM_PREFIX/lib/pkgconfig/libarchive.pc
}
