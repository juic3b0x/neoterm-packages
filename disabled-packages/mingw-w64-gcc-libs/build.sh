NEOTERM_PKG_HOMEPAGE=https://gcc.gnu.org/
NEOTERM_PKG_DESCRIPTION="Libraries coming with GCC (libgcc, libstdc++, etc.)"
NEOTERM_PKG_LICENSE="GPL-3.0, LGPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=(12.2.0)
NEOTERM_PKG_VERSION+=(2.39)  # GNU Binutils version
NEOTERM_PKG_VERSION+=(4.1.0) # GNU MPFR version
NEOTERM_PKG_VERSION+=(1.2.1) # GNU MPC version
NEOTERM_PKG_SRCURL=(https://ftp.gnu.org/gnu/gcc/gcc-${NEOTERM_PKG_VERSION}/gcc-${NEOTERM_PKG_VERSION}.tar.xz
                   https://ftp.gnu.org/gnu/binutils/binutils-${NEOTERM_PKG_VERSION[1]}.tar.xz
                   https://ftp.gnu.org/gnu/mpfr/mpfr-${NEOTERM_PKG_VERSION[2]}.tar.xz
                   https://ftp.gnu.org/gnu/mpc/mpc-${NEOTERM_PKG_VERSION[3]}.tar.gz)
NEOTERM_PKG_SHA256=(e549cf9cf3594a00e27b6589d4322d70e0720cdd213f39beb4181e06926230ff
                   645c25f563b8adc0a81dbd6a41cffbf4d37083a382e02d5d3df4f65c09516d00
                   0c98a3f1732ff6ca4ea690552079da9c597872d30e96ec28414ee23c95558a7f
                   17503d2c395dfcf106b622dc142683c1199431d095367c6aacba6eec30340459)
NEOTERM_PKG_BUILD_DEPENDS="mingw-w64-crt"
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_NO_STATICSPLIT=true
NEOTERM_PKG_HOSTBUILD=true

neoterm_step_post_get_source() {
	rm -rf .src
	mkdir -p .src
	mv binutils-${NEOTERM_PKG_VERSION[1]} .src/binutils
	mv mpfr-${NEOTERM_PKG_VERSION[2]} .src/mpfr
	mv mpc-${NEOTERM_PKG_VERSION[3]} .src/mpc
}

neoterm_step_host_build() {
	local _PREFIX_FOR_BUILD="${NEOTERM_PKG_HOSTBUILD_DIR}/prefix"
	export PATH="${_PREFIX_FOR_BUILD}/bin:$PATH"

	export CFLAGS="-O2"
	export CXXFLAGS="-O2"

	mkdir -p mpfr
	pushd mpfr
	$NEOTERM_PKG_SRCDIR/.src/mpfr/configure \
		--prefix="${_PREFIX_FOR_BUILD}"
	make -j "${NEOTERM_MAKE_PROCESSES}"
	make install
	popd # mpfr

	mkdir -p mpc
	pushd mpc
	$NEOTERM_PKG_SRCDIR/.src/mpc/configure \
		--prefix="${_PREFIX_FOR_BUILD}" \
		--with-mpfr="${_PREFIX_FOR_BUILD}"
	make -j "${NEOTERM_MAKE_PROCESSES}"
	make install
	popd # mpc

	local gcc_version="$(cat ${NEOTERM_PKG_SRCDIR}/gcc/BASE-VER)"

	local arch
	for arch in x86_64 i686; do
		local target="${arch}-w64-mingw32"
		local sysroot="${NEOTERM_PREFIX}/${target}"
		mkdir -p "${target}"
		pushd "${target}"

		mkdir -p binutils
		pushd binutils
		$NEOTERM_PKG_SRCDIR/.src/binutils/configure \
			--prefix="${_PREFIX_FOR_BUILD}" \
			--target="${target}"
		make -j "${NEOTERM_MAKE_PROCESSES}"
		make install
		popd # binutils

		mkdir -p gcc
		pushd gcc
		$NEOTERM_PKG_SRCDIR/configure \
			--prefix="${_PREFIX_FOR_BUILD}" \
			--target="${target}" \
			--with-sysroot="${sysroot}" \
			--disable-multilib \
			--with-mpfr="${_PREFIX_FOR_BUILD}" \
			--with-mpc="${_PREFIX_FOR_BUILD}" \
			--enable-languages=c,c++
		make -j "${NEOTERM_MAKE_PROCESSES}"
		make install
		popd # gcc

		install -Dm600 -t "${sysroot}/usr/bin" \
			"${_PREFIX_FOR_BUILD}/${target}/lib"/*.dll
		install -Dm600 -t "${sysroot}/usr/lib" \
			"${_PREFIX_FOR_BUILD}/${target}/lib"/*.a \
			"${_PREFIX_FOR_BUILD}/lib/gcc/${target}/${gcc_version}"/*.a
		cp -rT "${_PREFIX_FOR_BUILD}/${target}/include/c++/${gcc_version}" \
			"${sysroot}/usr/include/c++"

		popd # "${target}"
	done
}

neoterm_step_configure() {
	:
}

neoterm_step_make_install() {
	:
}
