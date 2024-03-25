NEOTERM_PKG_HOMEPAGE=https://grpc.io/
NEOTERM_PKG_DESCRIPTION="High performance, open source, general RPC framework that puts mobile and HTTP/2 first"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_SRCURL=git+https://github.com/grpc/grpc
NEOTERM_PKG_VERSION="1.62.1"
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="latest-release-tag"
NEOTERM_PKG_DEPENDS="abseil-cpp, c-ares, ca-certificates, libc++, libre2, openssl, python, zlib"
NEOTERM_PKG_BUILD_DEPENDS="gflags, gflags-static"
NEOTERM_PKG_PYTHON_COMMON_DEPS="wheel, 'setuptools==65.4.1', 'Cython<3'"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	rm CMakeLists.txt Makefile Rakefile

	export GRPC_PYTHON_BUILD_SYSTEM_OPENSSL=1
	export GRPC_PYTHON_BUILD_SYSTEM_ZLIB=1
	export GRPC_PYTHON_BUILD_SYSTEM_CARES=1
	export GRPC_PYTHON_BUILD_SYSTEM_RE2=1
	export GRPC_PYTHON_BUILD_SYSTEM_ABSL=1
	export GRPC_PYTHON_BUILD_WITH_CYTHON=1
}
