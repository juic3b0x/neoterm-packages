NEOTERM_PKG_HOMEPAGE=https://libgit2.github.com/
NEOTERM_PKG_DESCRIPTION="C library implementing Git core methods"
# License: GPL-2.0 with linking exception
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_LICENSE_FILE="COPYING"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.7.2"
NEOTERM_PKG_SRCURL=https://github.com/libgit2/libgit2/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=de384e29d7efc9330c6cdb126ebf88342b5025d920dcb7c645defad85195ea7f
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libssh2, openssl, pcre2, zlib"
NEOTERM_PKG_BUILD_DEPENDS="libiconv, libpcreposix"
NEOTERM_PKG_BREAKS="libgit2-dev"
NEOTERM_PKG_REPLACES="libgit2-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_TESTS=OFF
-DUSE_SSH=ON
-DREGEX_BACKEND=pcre2
"

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=1.7

	local v=$(echo ${NEOTERM_PKG_VERSION#*:} | cut -d . -f 1-2)
	if [ "${v}" != "${_SOVERSION}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}

neoterm_step_pre_configure() {
	find "$NEOTERM_PKG_SRCDIR" -name CMakeLists.txt | xargs -n 1 \
		sed -i 's/\( PROPERTIES C_STANDARD\) 90/\1 99/g'
}
