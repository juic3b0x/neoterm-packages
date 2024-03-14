NEOTERM_PKG_HOMEPAGE=https://libevent.org/
NEOTERM_PKG_DESCRIPTION="Library that provides asynchronous event notification"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.1.12
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://github.com/libevent/libevent/archive/release-${NEOTERM_PKG_VERSION}-stable.tar.gz
NEOTERM_PKG_SHA256=7180a979aaa7000e1264da484f712d403fcf7679b1e9212c4e3d09f5c93efc24
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
NEOTERM_PKG_BREAKS="libevent-dev"
NEOTERM_PKG_REPLACES="libevent-dev"
NEOTERM_PKG_RM_AFTER_INSTALL="bin/event_rpcgen.py"

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DEVENT__BUILD_SHARED_LIBRARIES=ON
-DEVENT__DISABLE_BENCHMARK=ON
-DEVENT__DISABLE_OPENSSL=ON
-DEVENT__DISABLE_REGRESS=ON
-DEVENT__DISABLE_SAMPLES=ON
-DEVENT__DISABLE_TESTS=ON
-DEVENT__DISABLE_TESTS=ON
-DEVENT__HAVE_WAITPID_WITH_WNOWAIT=ON
-DEVENT__SIZEOF_PTHREAD_T=$((NEOTERM_ARCH_BITS/8))
"

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after RELEASE / SOVERSION is changed.
	local _RELEASE=2.1
	local _SOVERSION=7

	for a in LIBVERSION_CURRENT LIBVERSION_AGE; do
		local _${a}=$(sed -En 's/.*set\(EVENT_ABI_'"${a}"'\s+([0-9]+)\).*/\1/p' \
				CMakeLists.txt)
	done
	local r=$(sed -En 's/.*set\(EVENT_PACKAGE_RELEASE\s+([0-9.]+)\).*/\1/p' \
			CMakeLists.txt)
	local v=$(( _LIBVERSION_CURRENT - _LIBVERSION_AGE ))
	if [ "${_RELEASE}" != "${r}" ] || \
		[ ! "${_LIBVERSION_CURRENT}" ] || [ "${_SOVERSION}" != "${v}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}
