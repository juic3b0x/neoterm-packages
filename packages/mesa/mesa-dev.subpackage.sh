NEOTERM_SUBPKG_DESCRIPTION="Mesa's OpenGL headers"
NEOTERM_SUBPKG_DEPEND_ON_PARENT="no"
NEOTERM_SUBPKG_DEPENDS="libglvnd-dev"
NEOTERM_SUBPKG_BREAKS="mesa (<< 22.3.3-2), ndk-sysroot (<< 25b-3)"
NEOTERM_SUBPKG_REPLACES="mesa (<< 22.3.3-2), ndk-sysroot (<< 25b-3)"
NEOTERM_SUBPKG_PLATFORM_INDEPENDENT=true
NEOTERM_SUBPKG_INCLUDE="
include/GL/!(osmesa.h)
include/EGL/
include/gbm.h
"
