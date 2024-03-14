NEOTERM_PKG_HOMEPAGE=https://www.capstone-engine.org/
NEOTERM_PKG_DESCRIPTION="Lightweight multi-platform, multi-architecture disassembly framework"
NEOTERM_PKG_LICENSE="BSD"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="5.0.1"
NEOTERM_PKG_SRCURL=https://github.com/capstone-engine/capstone/archive/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=2b9c66915923fdc42e0e32e2a9d7d83d3534a45bb235e163a70047951890c01a
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BREAKS="capstone-dev"
NEOTERM_PKG_REPLACES="capstone-dev"

neoterm_step_post_get_source() {
	neoterm_setup_cmake

	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=5

	local v=$(sed -En 's/.*VERSION_MAJOR.*[ |=]([0-9]+).*/\1/p' \
			CMakeLists.txt)
	if [ -z "${v}" ]; then
		local tmpdir=$(mktemp -d)
		cmake -S "${NEOTERM_PKG_SRCDIR}" -B "${tmpdir}"
		v=$(sed -En 's/.*VERSION_MAJOR.*[ |=]([0-9]+).*/\1/p' \
			"${tmpdir}/CMakeCache.txt")
		rm -fr "${tmpdir}"
	fi
	if [ "${v}" != "${_SOVERSION}" ]; then
		neoterm_error_exit "
		SOVERSION guard check failed!
		SOVERSION guard    = ${_SOVERSION}
		SOVERSION computed = ${v}
		"
	fi
}

neoterm_step_post_make_install() {
	# build system can only build static or shared at a time
	NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+="
	-DBUILD_SHARED_LIBS=ON
	"
	neoterm_step_configure
	neoterm_step_make
	neoterm_step_make_install
}
