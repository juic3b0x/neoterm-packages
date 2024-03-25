NEOTERM_PKG_HOMEPAGE=https://github.com/Oblomov/clinfo
NEOTERM_PKG_DESCRIPTION="Print all known information about all available OpenCL platforms and devices in the system"
NEOTERM_PKG_LICENSE="CC0-1.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.0.23.01.25
NEOTERM_PKG_SRCURL=https://github.com/Oblomov/clinfo/archive/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=6dcdada6c115873db78c7ffc62b9fc1ee7a2d08854a3bccea396df312e7331e3
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_BUILD_DEPENDS="opencl-headers"
NEOTERM_PKG_DEPENDS="ocl-icd"
NEOTERM_PKG_BUILD_IN_SRC=true

# https://github.com/Oblomov/clinfo/blob/master/Makefile#L7
# clinfo has added detection for building on device
# and wrapper for running on device
# which directly link against /vendor/lib64/libOpenCL.so
# This conflicts with using ocl-icd
NEOTERM_PKG_EXTRA_MAKE_ARGS="OS=Linux"

NEOTERM_PKG_EXTRA_MAKE_ARGS+="
MANDIR=$NEOTERM_PREFIX/share/man
"
