NEOTERM_SUBPKG_DESCRIPTION="Mesa's Swrast Vulkan ICD"
NEOTERM_SUBPKG_DEPEND_ON_PARENT="no"
NEOTERM_SUBPKG_DEPENDS="libandroid-shmem, libc++, libdrm, libx11, libxcb, libxshmfence, libwayland, ncurses, vulkan-loader-generic, zlib, zstd"
NEOTERM_SUBPKG_INCLUDE="
lib/libvulkan_lvp.so
share/vulkan/icd.d/lvp_icd.*.json
"
