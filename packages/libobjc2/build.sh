NEOTERM_PKG_HOMEPAGE=http://www.gnustep.org/
NEOTERM_PKG_DESCRIPTION="The GNUstep Objective-C runtime"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.1
NEOTERM_PKG_REVISION=2
_ROBIN_MAP_COMMIT=757de829927489bee55ab02147484850c687b620
NEOTERM_PKG_SRCURL=(https://github.com/gnustep/libobjc2/archive/v${NEOTERM_PKG_VERSION}.tar.gz
                   https://github.com/Tessil/robin-map/archive/${_ROBIN_MAP_COMMIT:0:7}.tar.gz)
NEOTERM_PKG_SHA256=(78fc3711db14bf863040ae98f7bdca08f41623ebeaf7efaea7dd49a38b5f054c
                   0abd2a272947d1d403ce7467e75aae5bdcfe839f4fc8d513ba5bfe170d5f2057)
NEOTERM_PKG_DEPENDS="libc++"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DENABLE_OBJCXX=OFF
-DGNUSTEP_CONFIG=OFF
-DTESTS=OFF
"

# https://github.com/gnustep/libobjc2/issues/199
NEOTERM_PKG_CONFLICTS="libblocksruntime"

neoterm_step_post_get_source() {
	mv robin-map-${_ROBIN_MAP_COMMIT}/* third_party/robin-map/
}

neoterm_step_pre_configure() {
	sed -i -e 's|@CMAKE_CXX_COMPILER@|'$CXX'|g' \
		"$NEOTERM_PKG_SRCDIR"/CMakeLists.txt
}
