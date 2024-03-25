NEOTERM_PKG_HOMEPAGE=https://github.com/protocolbuffers/protobuf
NEOTERM_PKG_DESCRIPTION="Protocol buffers C++ library (static)"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
# Please align the version with `libprotobuf` package.
NEOTERM_PKG_VERSION=25.1
NEOTERM_PKG_SRCURL=https://github.com/protocolbuffers/protobuf/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=9bd87b8280ef720d3240514f884e56a712f2218f0d693b48050c836028940a42
NEOTERM_PKG_DEPENDS="protobuf (>= 2:${NEOTERM_PKG_VERSION})"
NEOTERM_PKG_BUILD_DEPENDS="libc++, zlib"
NEOTERM_PKG_BREAKS="libprotobuf (<< 2:21.12)"
NEOTERM_PKG_REPLACES="libprotobuf (<< 2:21.12)"
NEOTERM_PKG_CONFLICTS="protobuf-dev"
NEOTERM_PKG_NO_STATICSPLIT=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dprotobuf_ABSL_PROVIDER=package
-Dprotobuf_BUILD_TESTS=OFF
-DBUILD_SHARED_LIBS=OFF
-DCMAKE_INSTALL_LIBDIR=lib
"

neoterm_step_pre_configure() {
	# Version guard
	local ver_shared=$(. $NEOTERM_SCRIPTDIR/packages/libprotobuf/build.sh; echo ${NEOTERM_PKG_VERSION#*:})
	local ver_static=${NEOTERM_PKG_VERSION#*:}
	if [ "${ver_shared}" != "${ver_static}" ]; then
		neoterm_error_exit "Version mismatch between libprotobuf and protobuf-static."
	fi

	# Preserve CMake files for shared libs
	local f
	for f in $NEOTERM_PREFIX/lib/cmake/protobuf/protobuf-targets{-release,}.cmake; do
		if [ -e "${f}" ]; then
			mv "${f}"{,.tmp}
		fi
	done
}

neoterm_step_post_massage() {
	find . ! -type d \
		! -wholename "./lib/*.a" \
		! -wholename "./lib/cmake/protobuf/protobuf-targets-release.cmake" \
		! -wholename "./lib/cmake/protobuf/protobuf-targets.cmake" \
		! -wholename "./share/doc/$NEOTERM_PKG_NAME/*" \
		-exec rm -f '{}' \;
	find . ! -type d \
		-wholename "./lib/libutf8_*" \
		-exec rm -f '{}' \;
	find . -type d -empty -delete

	# Restore CMake files for shared libs
	local f
	for f in $NEOTERM_PREFIX/lib/cmake/protobuf/protobuf-targets{-release,}.cmake; do
		if [ -e "${f}".tmp ]; then
			mv "${f}"{.tmp,}
		fi
	done
}
