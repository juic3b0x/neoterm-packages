NEOTERM_PKG_HOMEPAGE=https://grpc.io/
NEOTERM_PKG_DESCRIPTION="High performance, open source, general RPC framework that puts mobile and HTTP/2 first"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_SRCURL=git+https://github.com/grpc/grpc
NEOTERM_PKG_VERSION="1.62.1"
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="abseil-cpp, c-ares, ca-certificates, libc++, libprotobuf, libre2, openssl, protobuf, zlib"
NEOTERM_PKG_BREAKS="libgrpc-dev"
NEOTERM_PKG_REPLACES="libgrpc-dev"
NEOTERM_PKG_BUILD_DEPENDS="gflags, gflags-static"
NEOTERM_PKG_HOSTBUILD=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_STRIP=$(command -v strip)
-DGIT_EXECUTABLE=$(command -v git)
-DBUILD_SHARED_LIBS=ON
-DgRPC_ABSL_PROVIDER=package
-DgRPC_CARES_PROVIDER=package
-DgRPC_PROTOBUF_PROVIDER=package
-DgRPC_SSL_PROVIDER=package
-DgRPC_RE2_PROVIDER=package
-DgRPC_ZLIB_PROVIDER=package
-DgRPC_GFLAGS_PROVIDER=package
-DRUN_HAVE_POSIX_REGEX=0
-DRUN_HAVE_STD_REGEX=0
-DRUN_HAVE_STEADY_CLOCK=0
-DProtobuf_PROTOC_LIBRARY=$NEOTERM_PREFIX/lib/libprotoc.so
"

neoterm_step_host_build() {
	neoterm_setup_cmake
	neoterm_setup_ninja

	export LD=gcc
	export LDXX=g++

	# -Wno-error=class-memaccess is used to avoid
	# src/core/lib/security/credentials/oauth2/oauth2_credentials.cc:336:61: error: ‘void* memset(void*, int, size_t)’ clearing an object of non-trivial type ‘struct grpc_oauth2_token_fetcher_credentials’; use assignment or value-initialization instead [-Werror=class-memaccess]
	# memset(c, 0, sizeof(grpc_oauth2_token_fetcher_credentials));
	# when building version 1.17.2:
	CXXFLAGS="-Wno-error=class-memaccess" \
		CFLAGS="-Wno-implicit-fallthrough" \
		cmake -G Ninja "$NEOTERM_PKG_SRCDIR"

	ninja grpc_cpp_plugin
}

neoterm_step_pre_configure() {
	neoterm_setup_protobuf
	neoterm_setup_cmake
	neoterm_setup_ninja

	export PATH=$NEOTERM_PKG_HOSTBUILD_DIR:$PATH
	export GRPC_CROSS_COMPILE=true

	CPPFLAGS+=" -DPROTOBUF_USE_DLLS"
	LDFLAGS+=" $($NEOTERM_SCRIPTDIR/packages/libprotobuf/interface_link_libraries.sh)"
}
