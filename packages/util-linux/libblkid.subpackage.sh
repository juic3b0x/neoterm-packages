NEOTERM_SUBPKG_DESCRIPTION="Block device identification library"
NEOTERM_SUBPKG_BREAKS="util-linux (<< 2.38.1-1)"
NEOTERM_SUBPKG_REPLACES="util-linux (<< 2.38.1-1)"
NEOTERM_SUBPKG_DEPEND_ON_PARENT="no"
NEOTERM_SUBPKG_INCLUDE="
include/blkid/blkid.h
lib/libblkid.so
lib/pkgconfig/blkid.pc
share/man/man3/libblkid.3.gz
"
