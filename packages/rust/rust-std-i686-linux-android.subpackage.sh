NEOTERM_SUBPKG_DESCRIPTION="Rust std for target i686-linux-android"
NEOTERM_SUBPKG_DEPEND_ON_PARENT=no
NEOTERM_SUBPKG_PLATFORM_INDEPENDENT=true
NEOTERM_SUBPKG_BREAKS="rust (<< 1.74.1-1)"
NEOTERM_SUBPKG_REPLACES="rust (<< 1.74.1-1)"
NEOTERM_SUBPKG_INCLUDE="
lib/rustlib/i686-linux-android/lib/*.rlib
lib/rustlib/i686-linux-android/lib/libstd-*.so
lib/rustlib/i686-linux-android/lib/libtest-*.so
"
