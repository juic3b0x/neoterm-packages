NEOTERM_SUBPKG_INCLUDE="
include/harfbuzz/hb-icu.h
lib/libharfbuzz-icu*
lib/pkgconfig/harfbuzz-icu.pc
"
NEOTERM_SUBPKG_DESCRIPTION="OpenType text shaping engine ICU backend"
NEOTERM_SUBPKG_DEPENDS="libicu"
NEOTERM_SUBPKG_BREAKS="harfbuzz (<< 7.0.0)"
NEOTERM_SUBPKG_REPLACES="harfbuzz (<< 7.0.0)"
