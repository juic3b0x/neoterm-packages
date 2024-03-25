NEOTERM_PKG_HOMEPAGE=https://github.com/protobuf-c/protobuf-c
NEOTERM_PKG_DESCRIPTION="Protocol buffers C library"
NEOTERM_PKG_LICENSE="BSD 2-Clause"
NEOTERM_PKG_MAINTAINER="Henrik Grimler @Grimler91"
NEOTERM_PKG_VERSION="1.5.0"
NEOTERM_PKG_SRCURL=https://github.com/protobuf-c/protobuf-c/releases/download/v${NEOTERM_PKG_VERSION}/protobuf-c-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=7b404c63361ed35b3667aec75cc37b54298d56dd2bcf369de3373212cc06fd98
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="abseil-cpp, libc++, libprotobuf, protobuf"
NEOTERM_PKG_BREAKS="libprotobuf-c-dev"
NEOTERM_PKG_REPLACES="libprotobuf-c-dev"

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=1

	local a
	for a in CURRENT AGE; do
		local _LT_${a}=$(sed -En 's/^LIBPROTOBUF_C_'"${a}"'=([0-9]+).*/\1/p' \
				Makefile.am)
	done
	local v=$(( _LT_CURRENT - _LT_AGE ))
	if [ ! "${_LT_CURRENT}" ] || [ "${v}" != "${_SOVERSION}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}

neoterm_step_pre_configure() {
	find protoc-c -name '*.h' | xargs -n 1 \
		sed -i -E 's/GOOGLE_DISALLOW_EVIL_CONSTRUCTORS\(([^)]+)\)/\1(const \1\&) = delete; void operator=(const \1\&) = delete/g'

	neoterm_setup_protobuf
	export PROTOC=$(command -v protoc)

	CXXFLAGS+=" -std=c++17"
	LDFLAGS+=" $($NEOTERM_SCRIPTDIR/packages/libprotobuf/interface_link_libraries.sh)"
}

neoterm_step_post_configure() {
	# Avoid overlinking
	sed -i 's/ -shared / -Wl,--as-needed\0/g' ./libtool
}
