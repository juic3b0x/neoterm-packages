NEOTERM_PKG_HOMEPAGE=https://www.unidata.ucar.edu/software/netcdf/
NEOTERM_PKG_DESCRIPTION="NetCDF is a set of software libraries and self-describing, machine-independent data formats that support the creation, access, and sharing of array-oriented scientific data"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="Henrik Grimler @Grimler91"
NEOTERM_PKG_VERSION="4.9.2"
NEOTERM_PKG_SRCURL=https://github.com/Unidata/netcdf-c/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=bc104d101278c68b303359b3dc4192f81592ae8640f1aee486921138f7f88cb7
NEOTERM_PKG_DEPENDS="libandroid-execinfo, libcurl, zlib"
NEOTERM_PKG_BREAKS="netcdf-c-dev"
NEOTERM_PKG_REPLACES="netcdf-c-dev"
NEOTERM_PKG_GROUPS="science"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--disable-hdf5"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=19

	local e=$(sed -En 's/.*\s+netCDF_SO_VERSION="?([0-9]+):([0-9]+):([0-9]+).*/\1-\3/p' \
				configure.ac)
	if [ ! "${e}" ] || [ "${_SOVERSION}" != "$(( "${e}" ))" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}

neoterm_step_pre_configure() {
	LDFLAGS+=" -landroid-execinfo"
}
