NEOTERM_PKG_HOMEPAGE=https://sourceware.org/libffi/
NEOTERM_PKG_DESCRIPTION="Library providing a portable, high level programming interface to various calling conventions"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.4.4
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/libffi/libffi/releases/download/v${NEOTERM_PKG_VERSION}/libffi-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=d66c56ad259a82cf2a9dfc408b32bf5da52371500b84745f7fb8b645712df676
NEOTERM_PKG_BREAKS="libffi-dev"
NEOTERM_PKG_REPLACES="libffi-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--disable-multi-os-directory"
NEOTERM_PKG_RM_AFTER_INSTALL="lib/libffi-${NEOTERM_PKG_VERSION}/include"

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=8

	local e=$(sed -En 's/^[^0-9#]*([0-9]+):([0-9]+):([0-9]+).*/\1-\3/p' \
			libtool-version)
	if [ ! "${e}" ] || [ "${_SOVERSION}" != "$(( "${e}" ))" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}

neoterm_step_post_configure() {
	# work around since mmap can't be written and marked executable in android anymore from userspace
	echo "#define FFI_MMAP_EXEC_WRIT 1" >> fficonfig.h
}
