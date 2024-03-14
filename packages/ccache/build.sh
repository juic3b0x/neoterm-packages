NEOTERM_PKG_HOMEPAGE=https://ccache.samba.org
NEOTERM_PKG_DESCRIPTION="Compiler cache for fast recompilation of C/C++ code"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="4.9.1"
NEOTERM_PKG_SRCURL=https://github.com/ccache/ccache/releases/download/v$NEOTERM_PKG_VERSION/ccache-$NEOTERM_PKG_VERSION.tar.xz
NEOTERM_PKG_SHA256=4c03bc840699127d16c3f0e6112e3f40ce6a230d5873daa78c60a59c7ef59d25
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libc++, zlib, zstd"

#[46/89] Building ASM object src/third_party/blake3/CMakeFiles/blake3.dir/blake3_sse2_x86-64_unix.S.o
#FAILED: src/third_party/blake3/CMakeFiles/blake3.dir/blake3_sse2_x86-64_unix.S.o
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DHAVE_ASM_AVX2=FALSE
-DHAVE_ASM_AVX512=FALSE
-DHAVE_ASM_SSE2=FALSE
-DHAVE_ASM_SSE41=FALSE
-DREDIS_STORAGE_BACKEND=OFF
"
