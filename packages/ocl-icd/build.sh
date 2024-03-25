NEOTERM_PKG_HOMEPAGE=https://github.com/OCL-dev/ocl-icd
NEOTERM_PKG_DESCRIPTION="OpenCL ICD Loader"
NEOTERM_PKG_LICENSE="BSD 2-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.3.2"
NEOTERM_PKG_SRCURL=https://github.com/OCL-dev/ocl-icd/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=ec47d7dcd961ea06695b067e8b7edb82e420ddce03e0081a908c62fd0b8535c5
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_NO_STATICSPLIT=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--enable-custom-vendordir=${NEOTERM_PREFIX}/etc/OpenCL/vendors
--enable-official-khronos-headers
"

neoterm_step_pre_configure() {
	./bootstrap
}

# https://www.khronos.org/registry/OpenCL/specs/2.2/html/OpenCL_ICD_Installation.html
# Intepreting this as providing library "libOpenCL.so" with SONAME "libOpenCL.so" on Android

# https://github.com/juic3b0x/neoterm-packages/issues/7510
# Removed handling of PREFIX/etc/OpenCL/vendors to match Desktop Linux ocl-icd behaviour
# Removed creation of android.icd as it never worked without modifying LD_LIBRARY_PATH on Android
# Driver packages (eg: clvk) should be the one handling the items above
