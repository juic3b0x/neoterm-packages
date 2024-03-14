NEOTERM_PKG_HOMEPAGE=https://github.com/KhronosGroup/Vulkan-Loader
NEOTERM_PKG_DESCRIPTION="Vulkan Loader"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.3.280"
NEOTERM_PKG_SRCURL=https://github.com/KhronosGroup/Vulkan-Loader/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=eb0d9cae11b06eb7d306605b97bfefcd31d40def97c7617c765f73f7535e3853
NEOTERM_PKG_BUILD_DEPENDS="vulkan-headers (=${NEOTERM_PKG_VERSION}), libx11, libxcb, libxrandr"
NEOTERM_PKG_CONFLICTS="vulkan-loader-android"
NEOTERM_PKG_PROVIDES="vulkan-loader-android"
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+.\d+.\d+"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_TESTS=OFF
-DCMAKE_SYSTEM_NAME=Linux
-DENABLE_WERROR=OFF
-DVULKAN_HEADERS_INSTALL_DIR=$NEOTERM_PREFIX
"

neoterm_step_pre_configure() {
	CPPFLAGS+=" -Wno-typedef-redefinition"
}

neoterm_step_post_make_install() {
	# Sanity check
	echo "INFO: ========== vulkan.pc =========="
	cat "$NEOTERM_PREFIX/lib/pkgconfig/vulkan.pc"
	echo "INFO: ========== vulkan.pc =========="

	# Lots of apps will search libvulkan.so.1
	local e=0
	[ ! -e "$NEOTERM_PREFIX"/lib/libvulkan.so ] && e=1
	[ ! -e "$NEOTERM_PREFIX"/lib/libvulkan.so.1 ] && e=1
	if [[ "${e}" != 0 ]]; then
		neoterm_error_exit "
		Symlink check failed!
		$(file "$NEOTERM_PREFIX"/lib/libvulkan.so)
		$(file "$NEOTERM_PREFIX"/lib/libvulkan.so.1)
		"
	fi
}
