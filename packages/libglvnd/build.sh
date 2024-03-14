NEOTERM_PKG_HOMEPAGE=https://gitlab.freedesktop.org/glvnd/libglvnd
NEOTERM_PKG_DESCRIPTION="The GL Vendor-Neutral Dispatch library"
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.7.0"
NEOTERM_PKG_SRCURL=https://gitlab.freedesktop.org/glvnd/libglvnd/-/archive/v${NEOTERM_PKG_VERSION}/libglvnd-v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=2b6e15b06aafb4c0b6e2348124808cbd9b291c647299eaaba2e3202f51ff2f3d
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libc++, libx11, libxext"
NEOTERM_PKG_BUILD_DEPENDS="xorgproto"
NEOTERM_PKG_BREAKS="mesa (<< 22.3.3-2)"
NEOTERM_PKG_CONFLICTS="libmesa, mesa (<< 22.3.3-2), ndk-sysroot (<= 25b)"
NEOTERM_PKG_REPLACES="libmesa, mesa (<< 22.3.3-2)"
NEOTERM_PKG_RECOMMENDS="mesa"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dtls=false
-Ddispatch-tls=false
"

neoterm_step_pre_configure() {
	# SOVERSION suffix is needed for SONAME of shared libs to avoid conflict
	# with system ones (in /system/lib64 or /system/lib):
	export NEOTERM_MESON_ENABLE_SOVERSION=1
}

neoterm_step_post_make_install() {
	patch --no-backup-if-mismatch -p1 -d $NEOTERM_PREFIX/include \
		< $NEOTERM_PKG_BUILDER_DIR/egl-not-android.diff
}

neoterm_step_install_license() {
	install -Dm600 -t $NEOTERM_PREFIX/share/doc/$NEOTERM_PKG_NAME \
		$NEOTERM_PKG_BUILDER_DIR/LICENSE
}

neoterm_step_post_massage() {
	# A bunch of programs in the wild assume that the name of OpenGL shared
	# library is `libGL.so.1` and try to dlopen(3) it. In fact `sdl2` does
	# this. Also `libEGL.so` and some others need SOVERSION suffix to avoid
	# conflict with system ones. So let's check if SONAME is properly set.
	local n
	for n in GL EGL GLESv1_CM GLESv2; do
		local f="lib/lib${n}.so"
		if [ ! -e "${f}" ]; then
			neoterm_error_exit "Shared library ${f} does not exist."
		fi
		if ! readelf -d "${f}" | grep -q '(SONAME).*\[lib'"${n}"'\.so\.'; then
			neoterm_error_exit "SONAME for ${f} is not properly set."
		fi
	done
}
