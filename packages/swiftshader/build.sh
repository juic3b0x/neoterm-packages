NEOTERM_PKG_HOMEPAGE=https://swiftshader.googlesource.com/SwiftShader
NEOTERM_PKG_DESCRIPTION="A high-performance CPU-based implementation of the Vulkan graphics API"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
_CHROMIUM_VERSION=110.0.5481.177
NEOTERM_PKG_VERSION=$_CHROMIUM_VERSION
NEOTERM_PKG_SRCURL=https://commondatastorage.googleapis.com/chromium-browser-official/chromium-$_CHROMIUM_VERSION.tar.xz
NEOTERM_PKG_SHA256=7b2f454d1195270a39f94a9ff6d8d68126be315e0da4e31c20f4ba9183a1c9b7
NEOTERM_PKG_DEPENDS="libandroid-shmem, libc++, vulkan-loader-generic"
NEOTERM_PKG_BUILD_DEPENDS="vulkan-headers"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DSWIFTSHADER_BUILD_TESTS=FALSE
-DSWIFTSHADER_WARNINGS_AS_ERRORS=FALSE
-DSPIRV_HEADERS_SKIP_INSTALL=ON
-DSKIP_SPIRV_TOOLS_INSTALL=OFF
"

neoterm_step_pre_configure() {
	NEOTERM_PKG_SRCDIR=$NEOTERM_PKG_SRCDIR/third_party/swiftshader
}

neoterm_step_make_install() {
	cp libvk_swiftshader.so $NEOTERM_PREFIX/lib

	mkdir -p $NEOTERM_PREFIX/share/vulkan/icd.d/
	python $NEOTERM_PKG_SRCDIR/src/Vulkan/write_icd_json.py \
		--input $NEOTERM_PKG_SRCDIR/src/Vulkan/vk_swiftshader_icd.json.tmpl \
		--output $NEOTERM_PREFIX/share/vulkan/icd.d/vk_swiftshader_icd.json \
		--library_path $NEOTERM_PREFIX/lib/libvk_swiftshader.so
}
