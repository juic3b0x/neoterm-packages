NEOTERM_SUBPKG_DESCRIPTION="Rust std for target armv7-linux-androideabi"
NEOTERM_SUBPKG_DEPEND_ON_PARENT=no
NEOTERM_SUBPKG_PLATFORM_INDEPENDENT=true
NEOTERM_SUBPKG_BREAKS="rust (<< 1.74.1-1)"
NEOTERM_SUBPKG_REPLACES="rust (<< 1.74.1-1)"
NEOTERM_SUBPKG_INCLUDE="
lib/rustlib/armv7-linux-androideabi/lib/*.rlib
lib/rustlib/armv7-linux-androideabi/lib/libstd-*.so
lib/rustlib/armv7-linux-androideabi/lib/libtest-*.so
"
