NEOTERM_PKG_HOMEPAGE=https://www.mesa3d.org
NEOTERM_PKG_DESCRIPTION="An open-source implementation of the OpenGL specification"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_LICENSE_FILE="docs/license.rst"
NEOTERM_PKG_MAINTAINER="xMeM <haooy@outlook.com>"
NEOTERM_PKG_VERSION="23.3.2"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://archive.mesa3d.org/mesa-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=3cfcb81fa16f89c56abe3855d2637d396ee4e03849b659000a6b8e5f57e69adc
NEOTERM_PKG_DEPENDS="libandroid-shmem, libc++, libdrm, libx11, libxcb, libxshmfence, libwayland, vulkan-loader-generic, zlib, zstd"
NEOTERM_PKG_BUILD_DEPENDS="libwayland-protocols, libxrandr, xorgproto"
NEOTERM_PKG_CONFLICTS="mesa-vulkan-icd-freedreno"

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--cmake-prefix-path $NEOTERM_PREFIX
-Dcpp_rtti=false
-Dgbm=disabled
-Dopengl=false
-Dllvm=disabled
-Dshared-llvm=disabled
-Dplatforms=x11,wayland
-Dgallium-drivers=
-Dxmlconfig=disabled
-Dvulkan-drivers=freedreno
-Dfreedreno-kmds=msm,kgsl
"

NEOTERM_PKG_BLACKLISTED_ARCHES="i686, x86_64"

neoterm_step_post_get_source() { 
 	# Do not use meson wrap projects 
 	rm -rf subprojects 
 }

neoterm_step_pre_configure() {
	neoterm_setup_cmake

	CPPFLAGS+=" -D__USE_GNU"
	LDFLAGS+=" -landroid-shmem"

	_WRAPPER_BIN=$NEOTERM_PKG_BUILDDIR/_wrapper/bin
	mkdir -p $_WRAPPER_BIN
	if [ "$NEOTERM_ON_DEVICE_BUILD" = "false" ]; then
		sed 's|@CMAKE@|'"$(command -v cmake)"'|g' \
			$NEOTERM_PKG_BUILDER_DIR/cmake-wrapper.in \
			> $_WRAPPER_BIN/cmake
		chmod 0700 $_WRAPPER_BIN/cmake
		sed "s|^export PKG_CONFIG_LIBDIR=|export PKG_CONFIG_LIBDIR=${NEOTERM_PREFIX}/opt/libwayland/cross/lib/x86_64-linux-gnu/pkgconfig:|" \
			"${NEOTERM_STANDALONE_TOOLCHAIN}/bin/pkg-config" \
			> "${_WRAPPER_BIN}/pkg-config"
		chmod +x "${_WRAPPER_BIN}/pkg-config"
		export PKG_CONFIG="${_WRAPPER_BIN}/pkg-config"
	fi
	export PATH=$_WRAPPER_BIN:$PATH
}

neoterm_step_post_configure() {
	rm -f $_WRAPPER_BIN/cmake
}
