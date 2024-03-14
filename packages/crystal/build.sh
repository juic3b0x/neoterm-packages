NEOTERM_PKG_HOMEPAGE=https://crystal-lang.org
NEOTERM_PKG_DESCRIPTION="Fast and statically typed, compiled language with Ruby-like syntax"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@HertzDevil"
NEOTERM_PKG_VERSION="1.11.2"
NEOTERM_PKG_GIT_BRANCH=$NEOTERM_PKG_VERSION
NEOTERM_PKG_SRCURL=git+https://github.com/crystal-lang/crystal
NEOTERM_PKG_AUTO_UPDATE=true
_LLVM_MAJOR_VERSION=$(. $NEOTERM_SCRIPTDIR/packages/libllvm/build.sh; echo $LLVM_MAJOR_VERSION)
_LLVM_MAJOR_VERSION_NEXT=$((_LLVM_MAJOR_VERSION + 1))
NEOTERM_PKG_DEPENDS="libc++, libevent, libgc, libgmp, libiconv, libllvm (<< $_LLVM_MAJOR_VERSION_NEXT), libxml2, libyaml, openssl, pcre2, zlib"
NEOTERM_PKG_RECOMMENDS="clang, libffi, make, pkg-config"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_BLACKLISTED_ARCHES="arm, i686, x86_64"

neoterm_step_make() {
	local SHARDS_VERSION=0.17.3
	local MOLINILLO_VERSION=0.2.0
	local MOLINILLO_URL=https://github.com/crystal-lang/crystal-molinillo/archive/v$MOLINILLO_VERSION.tar.gz
	local MOLINILLO_TARFILE=$NEOTERM_PKG_TMPDIR/crystal-molinillo-$MOLINILLO_VERSION.tar.gz
	local MOLINILLO_SHA256=e231cf2411a6a11a1538983c7fb52b19e650acc3338bd3cdf6fdb13d6463861a

	neoterm_setup_crystal

	CC="$CC_FOR_BUILD" ANDROID_PLATFORM="$NEOTERM_PKG_API_LEVEL" LLVM_CONFIG="$NEOTERM_PREFIX/bin/llvm-config" \
		make crystal target=$NEOTERM_HOST_PLATFORM release=1 FLAGS=-Dwithout_iconv

	$CC .build/crystal.o -o .build/crystal $LDFLAGS -rdynamic src/llvm/ext/llvm_ext.o \
		$("$NEOTERM_PREFIX/bin/llvm-config" --libs --system-libs --ldflags 2> /dev/null) \
		-lstdc++ -lpcre2-8 -lm -lgc -levent -ldl

	git clone --depth 1 --single-branch \
		--branch v$SHARDS_VERSION \
		https://github.com/crystal-lang/shards.git

	cd shards
	mkdir -p lib/molinillo
	neoterm_download "$MOLINILLO_URL" "$MOLINILLO_TARFILE" "$MOLINILLO_SHA256"
	tar xzf "$MOLINILLO_TARFILE" --strip-components=1 -C lib/molinillo
	CC="$CC_FOR_BUILD" ANDROID_PLATFORM="$NEOTERM_PKG_API_LEVEL" \
		make SHARDS=false release=1 \
		FLAGS="--cross-compile --target $NEOTERM_HOST_PLATFORM -Dwithout_iconv"
	$CC bin/shards.o -o bin/shards $LDFLAGS -rdynamic \
		-lyaml -lpcre2-8 -lgc -levent -ldl
}

neoterm_step_make_install() {
	make install PREFIX="$NEOTERM_PREFIX"
	cd shards && make install PREFIX="$NEOTERM_PREFIX"
}
