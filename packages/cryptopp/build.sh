NEOTERM_PKG_HOMEPAGE=https://www.cryptopp.com/
NEOTERM_PKG_DESCRIPTION="A free C++ class library of cryptographic schemes"
NEOTERM_PKG_LICENSE="BSL-1.0, BSD 3-Clause"
NEOTERM_PKG_LICENSE_FILE="License.txt"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="8.9.0"
NEOTERM_PKG_SRCURL=https://github.com/weidai11/cryptopp/archive/refs/tags/CRYPTOPP_${NEOTERM_PKG_VERSION//./_}.tar.gz
NEOTERM_PKG_SHA256=ab5174b9b5c6236588e15a1aa1aaecb6658cdbe09501c7981ac8db276a24d9ab
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+.\d+.\d+"
NEOTERM_PKG_DEPENDS="libc++"
NEOTERM_PKG_BUILD_DEPENDS="libcpufeatures"
NEOTERM_PKG_BREAKS="cryptopp-dev"
NEOTERM_PKG_REPLACES="cryptopp-dev"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_MAKE_INSTALL_TARGET="install-lib"

NEOTERM_PKG_RM_AFTER_INSTALL="
bin/
share/cryptopp/
"

neoterm_step_post_massage() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION_GUARD_FILES="lib/libcryptopp.so.8"
	local f
	for f in ${_SOVERSION_GUARD_FILES}; do
		if [ ! -e "${f}" ]; then
			neoterm_error_exit "SOVERSION guard check failed."
		fi
	done
}

neoterm_step_pre_configure() {
	export CXXFLAGS+=" -fPIC -I$NEOTERM_PREFIX/include/ndk_compat -fPIC"
	export NEOTERM_PKG_EXTRA_MAKE_ARGS+=" all static dynamic libcryptopp.pc CC=$CC CXX=$CXX"
	export CFLAGS+=" -I$NEOTERM_PREFIX/include/ndk_compat"
	export LDFLAGS+=" -l:libndk_compat.a"
}
