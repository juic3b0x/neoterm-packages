NEOTERM_PKG_HOMEPAGE=https://www.mesa3d.org
NEOTERM_PKG_DESCRIPTION="An open-source implementation of the OpenGL specification"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_LICENSE_FILE="docs/license.rst"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="23.3.5"
NEOTERM_PKG_SRCURL=https://archive.mesa3d.org/mesa-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=69ccb1278641ff5bad71ca0f866188aeb1a92aadc4dbb9d35f50aebec5b8b50f
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libandroid-shmem, libc++, libdrm, libglvnd, libwayland, libx11, libxext, libxfixes, libxshmfence, libxxf86vm, ncurses, vulkan-loader, zlib, zstd"
NEOTERM_PKG_SUGGESTS="mesa-dev"
NEOTERM_PKG_BUILD_DEPENDS="libllvm-static, libwayland-protocols, libxrandr, llvm, llvm-tools, mlir, xorgproto"
NEOTERM_PKG_CONFLICTS="libmesa, ndk-sysroot (<= 25b)"
NEOTERM_PKG_REPLACES="libmesa"

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--cmake-prefix-path $NEOTERM_PREFIX
-Dcpp_rtti=false
-Dgbm=enabled
-Dopengl=true
-Degl=enabled
-Degl-native-platform=x11
-Dgles1=disabled
-Dgles2=enabled
-Ddri3=enabled
-Dglx=dri
-Dllvm=enabled
-Dshared-llvm=disabled
-Dplatforms=x11,wayland
-Dgallium-drivers=swrast,virgl,zink
-Dosmesa=true
-Dglvnd=true
-Dxmlconfig=disabled
"

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

	if [ $NEOTERM_ARCH = "arm" ] || [ $NEOTERM_ARCH = "aarch64" ]; then
		NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" -Dvulkan-drivers=swrast,freedreno"
		NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" -Dfreedreno-kmds=msm,kgsl"
	elif [ $NEOTERM_ARCH = "i686" ] || [ $NEOTERM_ARCH = "x86_64" ]; then
		NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" -Dvulkan-drivers=swrast"
	else
		neoterm_error_exit "Invalid arch: $NEOTERM_ARCH"
	fi
}

neoterm_step_post_configure() {
	rm -f $_WRAPPER_BIN/cmake
}

neoterm_step_post_make_install() {
	# Avoid hard links
	local f1
	for f1 in $NEOTERM_PREFIX/lib/dri/*; do
		if [ ! -f "${f1}" ]; then
			continue
		fi
		local f2
		for f2 in $NEOTERM_PREFIX/lib/dri/*; do
			if [ -f "${f2}" ] && [ "${f1}" != "${f2}" ]; then
				local s1=$(stat -c "%i" "${f1}")
				local s2=$(stat -c "%i" "${f2}")
				if [ "${s1}" = "${s2}" ]; then
					ln -sfr "${f1}" "${f2}"
				fi
			fi
		done
	done

	# Create symlinks
	ln -sf libEGL_mesa.so ${NEOTERM_PREFIX}/lib/libEGL_mesa.so.0
	ln -sf libGLX_mesa.so ${NEOTERM_PREFIX}/lib/libGLX_mesa.so.0
}
