NEOTERM_PKG_HOMEPAGE=https://github.com/saghul/txiki.js
NEOTERM_PKG_DESCRIPTION="A small and powerful JavaScript runtime"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1:22.11.1
NEOTERM_PKG_SRCURL=git+https://github.com/saghul/txiki.js
NEOTERM_PKG_DEPENDS="libcurl, libffi"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_NATIVE=OFF
-DUSE_EXTERNAL_FFI=ON
-DFFI_INCLUDE_DIR=$NEOTERM_PREFIX/include
-DFFI_LIB=$NEOTERM_PREFIX/lib/libffi.so
"
NEOTERM_PKG_HOSTBUILD=true

# Build failure for i686:
#   [...]/txikijs/src/deps/wasm3/source/./extra/wasi_core.h:46:1:
#   fatal error: static_assert failed due to requirement
#   '__alignof(long long) == 8' "non-wasi data layout"
#   _Static_assert(_Alignof(int64_t) == 8, "non-wasi data layout");
#   ^              ~~~~~~~~~~~~~~~~~~~~~~
NEOTERM_PKG_BLACKLISTED_ARCHES="i686"

neoterm_step_host_build() {
	find $NEOTERM_PKG_SRCDIR -mindepth 1 -maxdepth 1 ! -name '.git*' \
		-exec cp -a \{\} ./ \;

	neoterm_setup_cmake

	cmake .
	make -j $NEOTERM_MAKE_PROCESSES
}

neoterm_step_post_configure() {
	export PATH=$NEOTERM_PKG_HOSTBUILD_DIR:$PATH
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin tjs
}
