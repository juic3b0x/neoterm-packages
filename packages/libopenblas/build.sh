NEOTERM_PKG_HOMEPAGE="https://www.openblas.net"
NEOTERM_PKG_DESCRIPTION="An optimized BLAS library based on GotoBLAS2 1.13 BSD"
NEOTERM_PKG_GROUPS="science"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.3.26"
NEOTERM_PKG_SRCURL="https://github.com/xianyi/OpenBLAS/archive/refs/tags/v$NEOTERM_PKG_VERSION.tar.gz"
NEOTERM_PKG_SHA256=4e6e4f5cb14c209262e33e6816d70221a2fe49eb69eaf0a06f065598ac602c68
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_FORCE_CMAKE=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS='
-DBUILD_SHARED_LIBS=ON
-DBUILD_STATIC_LIBS=ON
-DC_LAPACK=ON
'

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=0

	local v=$(echo ${NEOTERM_PKG_VERSION#*:} | cut -d . -f 1)
	if [ "${v}" != "${_SOVERSION}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}

neoterm_step_pre_configure() {
	if [ "$NEOTERM_ARCH" = "x86_64" ] || [ "$NEOTERM_ARCH" = "i686" ]; then
		NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+='-DTARGET=CORE2'
	fi
}

neoterm_step_post_make_install() {
	mkdir -p $NEOTERM_PREFIX/lib/pkgconfig
	pushd $NEOTERM_PREFIX/lib
	local _lib
	for _lib in blas cblas lapack lapacke; do
		rm -f lib${_lib}.a lib${_lib}.so lib${_lib}.so.3 pkgconfig/${_lib}.pc
		ln -s libopenblas.a lib${_lib}.a
		ln -s libopenblas.so lib${_lib}.so
		ln -s libopenblas.so lib${_lib}.so.3
		ln -s openblas.pc pkgconfig/${_lib}.pc
	done
	popd # $NEOTERM_PREFIX/lib
}
