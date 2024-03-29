NEOTERM_PKG_HOMEPAGE=https://neoterm.dev
NEOTERM_PKG_DESCRIPTION="OpenCL driver from system vendor"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.3
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_RECOMMENDS="binutils | binutils-is-llvm, ocl-icd, patchelf"
NEOTERM_PKG_SKIP_SRC_EXTRACT=true

neoterm_step_make_install() {
	echo "${NEOTERM_PREFIX}/opt/vendor/lib/libOpenCL.so" > vendor.icd
	install -Dm644 vendor.icd "${NEOTERM_PREFIX}/etc/OpenCL/vendors/vendor.icd"
	install -Dm644 /dev/null "${NEOTERM_PREFIX}/opt/vendor/lib/libOpenCL.so"
}

neoterm_step_create_debscripts() {
	cp -f "${NEOTERM_PKG_BUILDER_DIR}/postinst.sh" postinst
	sed -i postinst -e "s|@NEOTERM_PREFIX@|${NEOTERM_PREFIX}|g"

	cat <<- EOF > prerm
	#!${NEOTERM_PREFIX}/bin/sh
	case "\$1" in
	purge|remove)
	rm -fr "${NEOTERM_PREFIX}/opt/vendor/lib"
	esac
	EOF
}

# Goal:
# To allow NeoTerm to use on-device OpenCL drivers without export
# LD_LIBRARY_PATH=/vendor/lib64 or other trickery

# What it does:
# Copies libOpenCL.so from /vendor or /system
# Find extra deps for libOpenCL.so
# Patchelf libOpenCL.so and deps

# List of libOpenCL.so drivers from different vendors:
# GPU                    SONAME             cl_khr_icd    Supported
# Arm Mali               libGLES_mali.so    y             y
# Qualcomm Adreno        libOpenCL.so       n             n
# Imagination PowerVR    libPVROCL.so       y             y
