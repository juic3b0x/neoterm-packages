NEOTERM_PKG_HOMEPAGE=https://github.com/google/brotli
NEOTERM_PKG_DESCRIPTION="lossless compression algorithm and format (command line utility)"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.1.0
NEOTERM_PKG_SRCURL=https://github.com/google/brotli/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=e720a6ca29428b803f4ad165371771f5398faba397edf6778837a18599ea13ff
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BREAKS="brotli-dev"
NEOTERM_PKG_REPLACES="brotli-dev"
NEOTERM_PKG_FORCE_CMAKE=true

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=1

	local _ABI_CURRENT=$(grep -E '^#define\s+BROTLI_ABI_CURRENT\s+' \
			c/common/version.h | awk '{ print $3 }')
	local _ABI_AGE=$(grep -E '^#define\s+BROTLI_ABI_AGE\s+' \
			c/common/version.h | awk '{ print $3 }')
	local v=$(( _ABI_CURRENT - _ABI_AGE ))
	if [ ! "${_ABI_CURRENT}" ] || [ ! "${_ABI_AGE}" ] || [ "${v}" != "${_SOVERSION}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}

neoterm_step_post_make_install() {
	mkdir -p $NEOTERM_PREFIX/share/man/man{1,3}
	cp $NEOTERM_PKG_SRCDIR/docs/brotli.1 $NEOTERM_PREFIX/share/man/man1/
	cp $NEOTERM_PKG_SRCDIR/docs/*.3 $NEOTERM_PREFIX/share/man/man3/
}
