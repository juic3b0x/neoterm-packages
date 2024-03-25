NEOTERM_PKG_HOMEPAGE=https://github.com/qt/qtwebengine
NEOTERM_PKG_DESCRIPTION="Qt 5 Web Engine Library"
NEOTERM_PKG_LICENSE="LGPL-3.0, LGPL-2.1, BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@licy183"
NEOTERM_PKG_VERSION="5.15.15"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=git+https://github.com/qt/qtwebengine
NEOTERM_PKG_GIT_BRANCH=v$NEOTERM_PKG_VERSION-lts
NEOTERM_PKG_DEPENDS="dbus, fontconfig, libc++, libexpat, libjpeg-turbo, libminizip, libnspr, libnss, libpng, libsnappy, libvpx, libwebp, libx11, libxkbfile, qt5-qtbase, qt5-qtdeclarative, zlib"
NEOTERM_PKG_BUILD_DEPENDS="libdrm, qt5-qtbase-cross-tools, qt5-qtdeclarative-cross-tools"
NEOTERM_PKG_NO_STATICSPLIT=true
NEOTERM_PKG_HOSTBUILD=true

neoterm_step_host_build() {
	# Generate ffmpeg headers for i686
	mkdir -p fake-bin
	ln -s $(command -v clang-15) fake-bin/clang
	ln -s $(command -v clang++-15) fake-bin/clang++
	
	PATH="$PWD/fake-bin:$PATH" python2 $NEOTERM_PKG_SRCDIR/src/3rdparty/chromium/third_party/ffmpeg/chromium/scripts/build_ffmpeg.py --config-only linux noasm-ia32
}

neoterm_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $NEOTERM_PREFIX.
	if $NEOTERM_ON_DEVICE_BUILD; then
		neoterm_error_exit "Package '$NEOTERM_PKG_NAME' is not safe for on-device builds."
	fi
}

neoterm_step_configure() {
	cd $NEOTERM_PKG_SRCDIR
	neoterm_setup_ninja
	neoterm_setup_nodejs

	# https://gitweb.gentoo.org/repo/gentoo.git/commit/?id=adb049350a5d4b15b5ee19739d9f2baed83f6acf
	export LDFLAGS+=" -Wl,--undefined-version"

	# Remove neoterm's dummy pkg-config
	local _host_pkg_config="$(cat $(command -v pkg-config) | grep exec | awk '{print $2}')"
	rm -rf $NEOTERM_PKG_TMPDIR/host-pkg-config-bin
	mkdir -p $NEOTERM_PKG_TMPDIR/host-pkg-config-bin
	ln -s $_host_pkg_config $NEOTERM_PKG_TMPDIR/host-pkg-config-bin/pkg-config
	ln -s $(command -v pkg-config) $NEOTERM_PKG_TMPDIR/host-pkg-config-bin/$NEOTERM_HOST_PLATFORM-pkg-config
	export PATH="$NEOTERM_PKG_TMPDIR/host-pkg-config-bin:$PATH"

	# Create dummy sysroot
	rm -rf $NEOTERM_PKG_TMPDIR/sysroot
	mkdir -p $NEOTERM_PKG_TMPDIR/sysroot
	pushd $NEOTERM_PKG_TMPDIR/sysroot
	mkdir -p usr/include usr/lib usr/bin
	cp -R $NEOTERM_STANDALONE_TOOLCHAIN/sysroot/usr/include/* usr/include
	cp -R $NEOTERM_STANDALONE_TOOLCHAIN/sysroot/usr/include/$NEOTERM_HOST_PLATFORM/* usr/include
	cp -R $NEOTERM_STANDALONE_TOOLCHAIN/sysroot/usr/lib/$NEOTERM_HOST_PLATFORM/$NEOTERM_PKG_API_LEVEL/* usr/lib/
	cp "$NEOTERM_STANDALONE_TOOLCHAIN/sysroot/usr/lib/$NEOTERM_HOST_PLATFORM/libc++_shared.so" usr/lib/
	cp "$NEOTERM_STANDALONE_TOOLCHAIN/sysroot/usr/lib/$NEOTERM_HOST_PLATFORM/libc++_static.a" usr/lib/
	cp "$NEOTERM_STANDALONE_TOOLCHAIN/sysroot/usr/lib/$NEOTERM_HOST_PLATFORM/libc++abi.a" usr/lib/
	cp -Rf $NEOTERM_PREFIX/include/* usr/include
	cp -Rf $NEOTERM_PREFIX/lib/* usr/lib
	ln -sf /data ./data
	popd

	# Dummy pthread, rt and resolve
	# TODO: Patch the building system and do not dummy `librt.so`.
	echo "INPUT(-llog -liconv -landroid-shmem)" > "$NEOTERM_PREFIX/lib/librt.so"
	echo '!<arch>' > "$NEOTERM_PREFIX/lib/libpthread.a"
	echo '!<arch>' > "$NEOTERM_PREFIX/lib/libresolv.a"

	# Copy ffmpeg headers for i686. They are generated without asm.
	rm -rf src/3rdparty/chromium/third_party/ffmpeg/chromium/config/{Chrome,Chromium}/linux-noasm/ia32
	mkdir -p src/3rdparty/chromium/third_party/ffmpeg/chromium/config/{Chrome,Chromium}/linux-noasm/ia32
	cp -Rfv $NEOTERM_PKG_HOSTBUILD_DIR/build.ia32.linux-noasm/Chrome/* src/3rdparty/chromium/third_party/ffmpeg/chromium/config/Chrome/linux-noasm/ia32
	cp -Rfv $NEOTERM_PKG_HOSTBUILD_DIR/build.ia32.linux-noasm/Chromium/* src/3rdparty/chromium/third_party/ffmpeg/chromium/config/Chromium/linux-noasm/ia32
	cp -fv src/3rdparty/chromium/third_party/ffmpeg/chromium/config/Chrome/linux-noasm/{x64,ia32}/libavutil/ffversion.h
	cp -fv src/3rdparty/chromium/third_party/ffmpeg/chromium/config/Chromium/linux-noasm/{x64,ia32}/libavutil/ffversion.h

	# Do not run ninja -v, unless NINJAFLAGS is set
	: ${NINJAFLAGS:=" "}
	export NINJAFLAGS

	cd $NEOTERM_PKG_BUILDDIR/

	"${NEOTERM_PREFIX}/opt/qt/cross/bin/qmake" \
		$NEOTERM_PKG_SRCDIR \
		QT_CONFIG-=no-pkg-config \
		DUMMY_SYSROOT=$NEOTERM_PKG_TMPDIR/sysroot \
		PKG_CONFIG_SYSROOT_DIR= \
		PKG_CONFIG_LIBDIR=$PKG_CONFIG_LIBDIR \
		PKG_CONFIG_EXECUTABLE=$(command -v pkg-config)
}

neoterm_step_post_make_install() {
	#######################################################
	##
	##  Fixes & cleanup.
	##
	#######################################################

	## Drop QMAKE_PRL_BUILD_DIR because reference the build dir.
	find "${NEOTERM_PREFIX}/lib" -type f -name "libQt5WebEngine*.prl" \
		-exec sed -i -e '/^QMAKE_PRL_BUILD_DIR/d' "{}" \;

	## Remove *.la files.
	find "${NEOTERM_PREFIX}/lib" -iname \*.la -delete

	# Remove dummy files
	rm $NEOTERM_PREFIX/lib/lib{{pthread,resolv}.a,rt.so}
}

neoterm_step_post_massage() {
	# Replace version for cmake
	local _QT_BASE_VERSION=$(. $NEOTERM_SCRIPTDIR/x11-packages/qt5-qtbase/build.sh; echo $NEOTERM_PKG_VERSION)
	sed -e "s|$NEOTERM_PKG_VERSION\ |$_QT_BASE_VERSION |" -i lib/cmake/*/*Config.cmake
}
