NEOTERM_PKG_HOMEPAGE=https://vkcom.github.io/kphp/
NEOTERM_PKG_DESCRIPTION="A PHP compiler"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
_COMMIT=b1b2cec0f0e1206e1c134830ebd1f28e21bbd330
NEOTERM_PKG_VERSION=2021.12.30
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=git+https://github.com/VKCOM/kphp
NEOTERM_PKG_GIT_BRANCH=master
NEOTERM_PKG_DEPENDS="fmt, libandroid-execinfo, libc++, libcurl, libmsgpack-cxx, libre2, libuber-h3, libucontext, libyaml-cpp, openssl-1.1, pcre, zstd"
NEOTERM_PKG_BUILD_DEPENDS="kphp-timelib"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DKPHP_TESTS=OFF
-DOPENSSL_INCLUDE_DIR=$NEOTERM_PREFIX/include/openssl-1.1
-DOPENSSL_LIBRARIES=$NEOTERM_PREFIX/lib/openssl-1.1
-DOPENSSL_CRYPTO_LIBRARY=$NEOTERM_PREFIX/lib/openssl-1.1/libcrypto.so.1.1
-DOPENSSL_SSL_LIBRARY=$NEOTERM_PREFIX/lib/openssl-1.1/libssl.so.1.1"
NEOTERM_PKG_BLACKLISTED_ARCHES="arm, i686"

neoterm_step_post_get_source() {
	git fetch --unshallow
	git checkout $_COMMIT

	local version="$(git log -1 --format=%cs | sed 's/-/./g')"
	if [ "$version" != "$NEOTERM_PKG_VERSION" ]; then
		echo -n "ERROR: The specified version \"$NEOTERM_PKG_VERSION\""
		echo " is different from what is expected to be: \"$version\""
		return 1
	fi
}

neoterm_step_pre_configure() {
	LDFLAGS+=" -landroid-execinfo"

	CFLAGS="-I$NEOTERM_PREFIX/include/openssl-1.1 $CFLAGS"
	CPPFLAGS="-I$NEOTERM_PREFIX/include/openssl-1.1 $CPPFLAGS"
	CXXFLAGS="-I$NEOTERM_PREFIX/include/openssl-1.1 $CXXFLAGS"
	LDFLAGS="-L$NEOTERM_PREFIX/lib/openssl-1.1 -Wl,-rpath=$NEOTERM_PREFIX/lib/openssl-1.1 $LDFLAGS"
}

neoterm_step_post_configure() {
	local f
	if [ "$NEOTERM_CMAKE_BUILD" == "Ninja" ]; then
		f=build.ninja
	else
		f=CMakeFiles/kphp2cpp.dir/link.txt
	fi
	sed -i -e 's/-l:libyaml-cpp\.a/-lyaml-cpp/g' \
		-e 's/-l:libre2\.a/-lre2/g' \
		$f

	local bin=$NEOTERM_PKG_BUILDDIR/_prefix/bin
	mkdir -p $bin
	for exe in generate_unicode_utils prepare_unicode_data; do
		$CC_FOR_BUILD $NEOTERM_PKG_SRCDIR/common/unicode/${exe//_/-}.cpp \
			-o ${bin}/${exe}
	done
	export PATH=$bin:$PATH
}
