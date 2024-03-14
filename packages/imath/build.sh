NEOTERM_PKG_HOMEPAGE=https://imath.readthedocs.io/
NEOTERM_PKG_DESCRIPTION="Library for vector/matrix and math operations, plus the half type"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.1.9
NEOTERM_PKG_SRCURL=https://github.com/AcademySoftwareFoundation/Imath/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=f1d8aacd46afed958babfced3190d2d3c8209b66da451f556abd6da94c165cf3
NEOTERM_PKG_DEPENDS="libc++"
NEOTERM_PKG_CONFLICTS="openexr2"
NEOTERM_PKG_REPLACES="openexr2"

neoterm_step_pre_configure() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=29

	local a
	for a in LIBTOOL_CURRENT LIBTOOL_AGE; do
		local _${a}=$(sed -En 's/^set\(IMATH_'"${a}"'\s+([0-9]+).*/\1/p' \
				CMakeLists.txt)
	done
	local v=$(( _LIBTOOL_CURRENT - _LIBTOOL_AGE ))
	if [ ! "${_LIBTOOL_CURRENT}" ] || [ "${v}" != "${_SOVERSION}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}
