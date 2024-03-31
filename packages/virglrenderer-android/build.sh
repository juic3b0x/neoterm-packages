NEOTERM_PKG_HOMEPAGE=https://virgil3d.github.io/
NEOTERM_PKG_DESCRIPTION="A virtual 3D GPU for use inside qemu virtual machines over OpenGLES libraries on Android"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@licy183"
NEOTERM_PKG_VERSION=(0.10.4)
NEOTERM_PKG_VERSION+=(1.5.10) # libepoxy version
NEOTERM_PKG_REVISION=4
NEOTERM_PKG_SRCURL=(https://gitlab.freedesktop.org/virgl/virglrenderer/-/archive/virglrenderer-${NEOTERM_PKG_VERSION[0]}/virglrenderer-virglrenderer-${NEOTERM_PKG_VERSION[0]}.tar.gz)
NEOTERM_PKG_SRCURL+=(https://github.com/anholt/libepoxy/archive/refs/tags/${NEOTERM_PKG_VERSION[1]}.tar.gz)
NEOTERM_PKG_SHA256=(fd9a1b12473f4cda8d87e6ba1a6e5714a24355e16b69ed85df5c21bf48f797fa)
NEOTERM_PKG_SHA256+=(a7ced37f4102b745ac86d6a70a9da399cc139ff168ba6b8002b4d8d43c900c15)
NEOTERM_PKG_DEPENDS="angle-android"

NEOTERM_PKG_HOSTBUILD=true

neoterm_step_post_get_source() {
	mv libepoxy-${NEOTERM_PKG_VERSION[1]} libepoxy
}

neoterm_step_host_build() {
	# This packages should use the Android NDK toolchain to compile, not
	# our custom toolchain, so I'd like to compile it in the hostbuild step.
	export PATH="$NDK/toolchains/llvm/prebuilt/linux-x86_64/bin:$PATH"
	export CCNEOTERM_HOST_PLATFORM=$NEOTERM_HOST_PLATFORM$NEOTERM_PKG_API_LEVEL
	if [ $NEOTERM_ARCH = arm ]; then
		CCNEOTERM_HOST_PLATFORM=armv7a-linux-androideabi$NEOTERM_PKG_API_LEVEL
	fi

	local _INSTALL_PREFIX=$NEOTERM_PREFIX/opt/$NEOTERM_PKG_NAME

	PKG_CONFIG="$NEOTERM_PKG_TMPDIR/host-build-pkg-config"
	local _HOST_PKGCONFIG=$(command -v pkg-config)
	cat > $PKG_CONFIG <<-HERE
		#!/bin/sh
		export PKG_CONFIG_DIR=
		export PKG_CONFIG_LIBDIR=$_INSTALL_PREFIX/lib/pkgconfig
		exec $_HOST_PKGCONFIG "\$@"
	HERE
	chmod +x $PKG_CONFIG

	AR=$(command -v llvm-ar)
	CC=$(command -v $CCNEOTERM_HOST_PLATFORM-clang)
	CXX=$(command -v $CCNEOTERM_HOST_PLATFORM-clang++)
	LD=$(command -v ld.lld)
	CFLAGS=""
	CPPFLAGS=""
	CXXFLAGS=""
	LDFLAGS="-Wl,-rpath=\$ORIGIN/../lib"
	STRIP=$(command -v llvm-strip)
	neoterm_setup_meson

	# Compile libepoxy
	mkdir -p libepoxy-build
	$NEOTERM_MESON $NEOTERM_PKG_SRCDIR/libepoxy libepoxy-build \
        --cross-file $NEOTERM_MESON_CROSSFILE \
        --prefix=$_INSTALL_PREFIX \
		--libdir lib \
        -Degl=yes -Dglx=no -Dx11=false
	ninja -C libepoxy-build install -j $NEOTERM_MAKE_PROCESSES

	# Compile virglrenderer
	mkdir -p virglrenderer-build
	$NEOTERM_MESON $NEOTERM_PKG_SRCDIR virglrenderer-build \
        --cross-file $NEOTERM_MESON_CROSSFILE \
        --prefix=$_INSTALL_PREFIX \
		--libdir lib \
        -Degl_without_gbm=true \
        -Dplatforms=egl
	ninja -C virglrenderer-build install -j $NEOTERM_MAKE_PROCESSES
}

neoterm_step_configure() {
	# Remove this marker all the time, as this package is architecture-specific
	rm -rf $NEOTERM_HOSTBUILD_MARKER
}

neoterm_step_make() {
	:
}

neoterm_step_make_install() {
	sed "s|@NEOTERM_PREFIX@|$NEOTERM_PREFIX|g" \
		$NEOTERM_PKG_BUILDER_DIR/virgl_test_server_android.in > \
		$NEOTERM_PREFIX/bin/virgl_test_server_android
	chmod +x $NEOTERM_PREFIX/bin/virgl_test_server_android
}

neoterm_step_install_license() {
	mkdir -p $NEOTERM_PREFIX/share/doc/$NEOTERM_PKG_NAME
	cp $NEOTERM_PKG_SRCDIR/COPYING $NEOTERM_PREFIX/share/doc/$NEOTERM_PKG_NAME/COPYING-virglrenderer
	cp $NEOTERM_PKG_SRCDIR/libepoxy/COPYING $NEOTERM_PREFIX/share/doc/$NEOTERM_PKG_NAME/COPYING-libepoxy
	cp $NEOTERM_PKG_BUILDER_DIR/COPYING-gl4es $NEOTERM_PREFIX/share/doc/$NEOTERM_PKG_NAME/COPYING-gl4es
}
