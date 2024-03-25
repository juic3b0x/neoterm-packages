NEOTERM_PKG_HOMEPAGE=https://github.com/protocolbuffers/protobuf
NEOTERM_PKG_DESCRIPTION="Protocol buffers C++ library"
# utf8_range is licensed under MIT
NEOTERM_PKG_LICENSE="BSD 3-Clause, MIT"
NEOTERM_PKG_LICENSE_FILE="LICENSE"
NEOTERM_PKG_MAINTAINER="@neoterm"
# When bumping version:
# - update SHA256 checksum for $_PROTOBUF_ZIP in
#     $NEOTERM_SCRIPTDIR/scripts/build/setup/neoterm_setup_protobuf.sh
# - ALWAYS bump revision of reverse dependencies and rebuild them.
NEOTERM_PKG_VERSION=2:25.1
NEOTERM_PKG_SRCURL=https://github.com/protocolbuffers/protobuf/archive/v${NEOTERM_PKG_VERSION#*:}.tar.gz
NEOTERM_PKG_SHA256=9bd87b8280ef720d3240514f884e56a712f2218f0d693b48050c836028940a42
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_DEPENDS="abseil-cpp, libc++, zlib"
NEOTERM_PKG_BREAKS="libprotobuf-dev, protobuf-static (<< ${NEOTERM_PKG_VERSION#*:})"
NEOTERM_PKG_REPLACES="libprotobuf-dev"
NEOTERM_PKG_FORCE_CMAKE=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dprotobuf_ABSL_PROVIDER=package
-Dprotobuf_BUILD_TESTS=OFF
-DBUILD_SHARED_LIBS=ON
-DCMAKE_INSTALL_LIBDIR=lib
"
NEOTERM_PKG_NO_STATICSPLIT=true

neoterm_step_post_make_install() {
	install -Dm600 -t $NEOTERM_PREFIX/share/doc/libutf8-range \
		$NEOTERM_PKG_SRCDIR/third_party/utf8_range/LICENSE
}
