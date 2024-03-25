NEOTERM_PKG_HOMEPAGE=https://libexpat.github.io/
NEOTERM_PKG_DESCRIPTION="XML parsing C library"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.6.1"
NEOTERM_PKG_SRCURL=https://github.com/libexpat/libexpat/releases/download/R_${NEOTERM_PKG_VERSION//./_}/expat-$NEOTERM_PKG_VERSION.tar.bz2
NEOTERM_PKG_SHA256=4677d957c0c6cb2a3321101944574c24113b637c7ab1cf0659a27c5babc201fd
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+.\d+.\d+"
NEOTERM_PKG_BREAKS="libexpat-dev"
NEOTERM_PKG_REPLACES="libexpat-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--without-xmlwf --without-docbook"

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=1

	local a
	for a in LIBCURRENT LIBAGE; do
		local _${a}=$(sed -En 's/^'"${a}"'=([0-9]+).*/\1/p' configure.ac)
	done
	local v=$(( _LIBCURRENT - _LIBAGE ))
	if [ ! "${_LIBCURRENT}" ] || [ "${v}" != "${_SOVERSION}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}

neoterm_step_pre_configure() {
	# SOVERSION suffix is needed for SONAME of shared libs to avoid conflict
	# with system ones (in /system/lib64 or /system/lib):
	sed -i 's/^\(linux\*android\)\*)/\1-noneoterm)/' configure
}

neoterm_step_post_massage() {
	# Check if SONAME is properly set:
	if ! readelf -d lib/libexpat.so | grep -q '(SONAME).*\[libexpat\.so\.'; then
		neoterm_error_exit "SONAME for libexpat.so is not properly set."
	fi
}
