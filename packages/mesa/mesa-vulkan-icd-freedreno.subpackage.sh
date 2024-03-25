NEOTERM_SUBPKG_DESCRIPTION="Mesa's Freedreno Vulkan ICD"
NEOTERM_SUBPKG_DEPEND_ON_PARENT="no"
NEOTERM_SUBPKG_DEPENDS="libandroid-shmem, libc++, libdrm, libx11, libxcb, libxshmfence, libwayland, vulkan-loader-generic, zlib, zstd"
NEOTERM_SUBPKG_EXCLUDED_ARCHES="i686, x86_64"
NEOTERM_SUBPKG_INCLUDE="
lib/libvulkan_freedreno.so
share/vulkan/icd.d/freedreno_icd.*.json
"
