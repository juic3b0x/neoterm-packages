NEOTERM_PKG_HOMEPAGE=https://github.com/thom311/libnl
NEOTERM_PKG_DESCRIPTION="Collection of libraries providing APIs to netlink protocol based Linux kernel interfaces"
NEOTERM_PKG_LICENSE="LGPL-2.1, GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="3.9.0"
NEOTERM_PKG_SRCURL=https://github.com/thom311/libnl/releases/download/libnl${NEOTERM_PKG_VERSION//./_}/libnl-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=aed507004d728a5cf11eab48ca4bf9e6e1874444e33939b9d3dfed25018ee9bb
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+.\d+.\d+"
NEOTERM_PKG_BREAKS="libnl-dev"
NEOTERM_PKG_REPLACES="libnl-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-pthreads
--enable-cli
"

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after RELEASE / SOVERSION is changed.
	local _RELEASE=3
	local _SOVERSION=200

	for a in MAJOR_VERSION LT_CURRENT LT_AGE; do
		local _${a}=$(sed -En 's/^m4_define\(\[libnl_'"${a,,}"'\],\s*\[([0-9]+).*/\1/p' \
				configure.ac)
	done
	local v=$(( _LT_CURRENT - _LT_AGE ))
	if [ "${_RELEASE}" != "${_MAJOR_VERSION}" ] || \
		[ ! "${_LT_CURRENT}" ] || [ "${_SOVERSION}" != "${v}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}

neoterm_step_pre_configure() {
	local _inc="$NEOTERM_PKG_SRCDIR/_getsubopt/include"
	rm -rf "${_inc}"
	mkdir -p "${_inc}"
	cp "$NEOTERM_PKG_BUILDER_DIR/getsubopt.h" "${_inc}"

	CPPFLAGS+=" -I${_inc}"

	local _lib="$NEOTERM_PKG_BUILDDIR/_getsubopt/lib"
	rm -rf "${_lib}"
	mkdir -p "${_lib}"
	pushd "${_lib}"/..
	$CC $CFLAGS $CPPFLAGS "$NEOTERM_PKG_BUILDER_DIR/getsubopt.c" \
		-fvisibility=hidden -c -o ./getsubopt.o
	$AR cru "${_lib}"/libgetsubopt.a ./getsubopt.o
	popd

	LDFLAGS+=" -L${_lib} -l:libgetsubopt.a"

	CFLAGS+=" -Dsockaddr_storage=__kernel_sockaddr_storage"
}
