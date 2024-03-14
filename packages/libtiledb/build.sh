NEOTERM_PKG_HOMEPAGE=https://tiledb.com/
NEOTERM_PKG_DESCRIPTION="A powerful engine for storing and accessing dense and sparse multi-dimensional arrays"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.20.1"
NEOTERM_PKG_SRCURL=https://github.com/TileDB-Inc/TileDB/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=d9d52de7eef25c9e358f0dd6e696dc11a08d5b4d6c4ede88f11afffd32ec31c2
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="ca-certificates, file, libbz2, libc++, liblz4, libspdlog, openssl, zlib, zstd"
NEOTERM_PKG_BUILD_DEPENDS="clipp, fmt"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DTILEDB_VCPKG=OFF
-DTILEDB_SUPERBUILD=OFF
-DTILEDB_WERROR=OFF
-DTILEDB_STATS=OFF
-DTILEDB_TESTS=OFF
-DTILEDB_WEBP=OFF
-DHAVE_AVX2_EXITCODE=1
-DHAVE_AVX2_EXITCODE__TRYRUN_OUTPUT=
-DTILEDB_LIBMAGIC_EP_BUILT=ON
-Dlibmagic_INCLUDE_DIR=$NEOTERM_PREFIX/include
-Dlibmagic_LIBRARIES=$NEOTERM_PREFIX/lib/libmagic.so
-Dlibmagic_FOUND=ON
-Dlibmagic_DICTIONARY=$NEOTERM_PREFIX/share/misc/magic.mgc
"

# XXX: TileDB assumes that `std::string_view::size_type` == `std::uint64_t`,
# XXX: but this is not true on 32-bit Android.
NEOTERM_PKG_BLACKLISTED_ARCHES="arm, i686"
