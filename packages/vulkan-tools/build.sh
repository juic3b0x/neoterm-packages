NEOTERM_PKG_HOMEPAGE=https://github.com/KhronosGroup/Vulkan-Tools
NEOTERM_PKG_DESCRIPTION="Vulkan Tools and Utilities"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.3.280"
NEOTERM_PKG_SRCURL=https://github.com/KhronosGroup/Vulkan-Tools/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=97cbe660c066eb5b00a2f33b501f7cd0baaf8996b997fcba185ce298c8835fed
NEOTERM_PKG_DEPENDS="libc++, libx11, libxcb, libwayland, vulkan-loader"
NEOTERM_PKG_BUILD_DEPENDS="libwayland-protocols, vulkan-headers (=${NEOTERM_PKG_VERSION}), vulkan-volk"
NEOTERM_PKG_ANTI_BUILD_DEPENDS="vulkan-loader"
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+.\d+.\d+"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DBUILD_CUBE=ON
-DBUILD_ICD=OFF
-DBUILD_WSI_WAYLAND_SUPPORT=ON
-DBUILD_WSI_XCB_SUPPORT=ON
-DBUILD_WSI_XLIB_SUPPORT=ON
-DPython3_EXECUTABLE=$(command -v python3)
-DVULKAN_HEADERS_INSTALL_DIR=${NEOTERM_PREFIX}
"

neoterm_step_pre_configure() {
	local _WRAPPER_BIN="${NEOTERM_PKG_BUILDDIR}/_wrapper/bin"
	mkdir -p "${_WRAPPER_BIN}"
	if [[ "${NEOTERM_ON_DEVICE_BUILD}" == "false" ]]; then
		sed "s|^export PKG_CONFIG_LIBDIR=|export PKG_CONFIG_LIBDIR=${NEOTERM_PREFIX}/opt/libwayland/cross/lib/x86_64-linux-gnu/pkgconfig:|" \
			"${NEOTERM_STANDALONE_TOOLCHAIN}/bin/pkg-config" \
			> "${_WRAPPER_BIN}/pkg-config"
		chmod +x "${_WRAPPER_BIN}/pkg-config"
		export PKG_CONFIG="${_WRAPPER_BIN}/pkg-config"
	fi
	export PATH="${_WRAPPER_BIN}:${PATH}"
}
