NEOTERM_PKG_HOMEPAGE=https://source.android.com/devices/graphics/arch-vulkan
NEOTERM_PKG_DESCRIPTION="Vulkan Loader for Android"
NEOTERM_PKG_LICENSE="NCSA"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=26b
NEOTERM_PKG_SRCURL=https://dl.google.com/android/repository/android-ndk-r${NEOTERM_PKG_VERSION}-linux.zip
NEOTERM_PKG_SHA256=ad73c0370f0b0a87d1671ed2fd5a9ac9acfd1eb5c43a7fbfbd330f85d19dd632
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_HOSTBUILD=true
NEOTERM_PKG_BUILD_IN_SRC=true

# Desktop Vulkan Loader
# https://github.com/KhronosGroup/Vulkan-Loader
# https://github.com/KhronosGroup/Vulkan-Loader/blob/master/loader/LoaderAndLayerInterface.md

# Android Vulkan Loader
# https://android.googlesource.com/platform/frameworks/native/+/master/vulkan
# https://android.googlesource.com/platform/frameworks/native/+/master/vulkan/libvulkan/libvulkan.map.txt

neoterm_step_host_build() {
	# Use NDK provided vulkan header version
	# instead of vulkan-loader-generic vulkan.pc
	# https://github.com/android/ndk/issues/1721
	cat <<- EOF > vulkan_header_version.c
	#include <stdio.h>
	#include "vulkan/vulkan_core.h"
	int main(void) {
		printf("%d.%d.%d\n",
			VK_HEADER_VERSION_COMPLETE >> 22,
			VK_HEADER_VERSION_COMPLETE >> 12 & 0x03ff,
			VK_HEADER_VERSION_COMPLETE & 0x0fff);
		return 0;
	}
	EOF
	rm -fr ./vulkan
	cp -fr "${NEOTERM_PKG_SRCDIR}/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/include/vulkan" ./vulkan
	cc vulkan_header_version.c -o vulkan_header_version
}

neoterm_step_post_make_install() {
	install -v -Dm644 \
		"toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/lib/${NEOTERM_HOST_PLATFORM}/${NEOTERM_PKG_API_LEVEL}/libvulkan.so" \
		"${NEOTERM_PREFIX}/lib/libvulkan.so"

	local vulkan_loader_version
	vulkan_loader_version="$(${NEOTERM_PKG_HOSTBUILD_DIR}/vulkan_header_version)"
	if [[ -z "${vulkan_loader_version}" ]]; then
		neoterm_error_exit "ERROR: Host built vulkan_header_version is not printing version!"
	fi

	# https://github.com/KhronosGroup/Vulkan-Loader/blob/master/loader/vulkan.pc.in
	cat <<- EOF > "${NEOTERM_PKG_TMPDIR}/vulkan.pc"
	prefix=${NEOTERM_PREFIX}
	exec_prefix=\${prefix}
	libdir=\${exec_prefix}/lib
	includedir=\${prefix}/include
	Name: Vulkan-Loader
	Description: Vulkan Loader
	Version: ${vulkan_loader_version}
	Libs: -L\${libdir} -lvulkan
	Cflags: -I\${includedir}
	EOF
	install -Dm644 "${NEOTERM_PKG_TMPDIR}/vulkan.pc" "${NEOTERM_PREFIX}/lib/pkgconfig/vulkan.pc"
	echo "INFO: ========== vulkan.pc =========="
	cat "${NEOTERM_PREFIX}/lib/pkgconfig/vulkan.pc"
	echo "INFO: ========== vulkan.pc =========="

	ln -fsv libvulkan.so "${NEOTERM_PREFIX}/lib/libvulkan.so.1"
}

neoterm_step_create_debscripts() {
	local system_lib="/system/lib"
	[[ "${NEOTERM_ARCH_BITS}" == "64" ]] && system_lib+="64"
	system_lib+="/libvulkan.so"
	local prefix_lib="${NEOTERM_PREFIX}/lib/libvulkan.so"

	cat <<- EOF > postinst
	#!${NEOTERM_PREFIX}/bin/sh
	if [ -e "${system_lib}" ]; then
	echo "Symlink ${system_lib} to ${prefix_lib} ..."
	ln -fsT "${system_lib}" "${prefix_lib}"
	fi
	EOF

	cat <<- EOF > postrm
	#!${NEOTERM_PREFIX}/bin/sh
	rm -f "${prefix_lib}"
	EOF
}
