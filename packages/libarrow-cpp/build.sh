NEOTERM_PKG_HOMEPAGE=https://github.com/apache/arrow
NEOTERM_PKG_DESCRIPTION="C++ libraries for Apache Arrow"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
# Align the version with `python-pyarrow` package.
NEOTERM_PKG_VERSION=15.0.1
NEOTERM_PKG_SRCURL=https://github.com/apache/arrow/archive/refs/tags/apache-arrow-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=a8b154a2870aa998019baeb22a6514477918a5831d4760a85b516cb4c9a3402a
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_METHOD=repology
NEOTERM_PKG_DEPENDS="libandroid-execinfo, libc++, liblz4, libprotobuf, libre2, libsnappy, utf8proc, zlib, zstd"
NEOTERM_PKG_BUILD_DEPENDS="rapidjson"
NEOTERM_PKG_BREAKS="libarrow-python (<< ${NEOTERM_PKG_VERSION})"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DARROW_BUILD_STATIC=OFF
-DARROW_CSV=ON
-DARROW_DATASET=ON
-DARROW_HDFS=ON
-DARROW_JEMALLOC=OFF
-DARROW_JSON=ON
-DARROW_ORC=ON
-DARROW_PARQUET=ON
-DARROW_RUNTIME_SIMD_LEVEL=NONE
-DARROW_SIMD_LEVEL=NONE
"

neoterm_step_pre_configure() {
	neoterm_setup_protobuf

	NEOTERM_PKG_SRCDIR+="/cpp"

	CPPFLAGS+=" -DPROTOBUF_USE_DLLS"
	LDFLAGS+=" -landroid-execinfo"

	# Fix linker script error for zlib 1.3
	LDFLAGS+=" -Wl,--undefined-version"
}
