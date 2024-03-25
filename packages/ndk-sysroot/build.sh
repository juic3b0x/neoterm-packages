NEOTERM_PKG_HOMEPAGE=https://developer.android.com/tools/sdk/ndk/index.html
NEOTERM_PKG_DESCRIPTION="System header and library files from the Android NDK needed for compiling C programs"
NEOTERM_PKG_LICENSE="NCSA"
NEOTERM_PKG_MAINTAINER="@neoterm"
# Version should be equal to NEOTERM_NDK_{VERSION_NUM,REVISION} in
# scripts/properties.sh
NEOTERM_PKG_VERSION=26b
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://dl.google.com/android/repository/android-ndk-r${NEOTERM_PKG_VERSION}-linux.zip
NEOTERM_PKG_SHA256=ad73c0370f0b0a87d1671ed2fd5a9ac9acfd1eb5c43a7fbfbd330f85d19dd632
NEOTERM_PKG_AUTO_UPDATE=false
# This package has taken over <pty.h> from the previous libutil-dev
# and iconv.h from libandroid-support-dev:
NEOTERM_PKG_CONFLICTS="libutil-dev, libgcc, libandroid-support-dev"
NEOTERM_PKG_REPLACES="libutil-dev, libgcc, libandroid-support-dev, ndk-stl"
NEOTERM_PKG_NO_STATICSPLIT=true
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_RM_AFTER_INSTALL="
include/EGL
include/GLES
include/GLES2
include/GLES3
include/KHR/khrplatform.h
include/execinfo.h
include/glob.h
include/iconv.h
include/spawn.h
include/sys/capability.h
include/sys/sem.h
include/sys/shm.h
include/unicode
include/vulkan
include/zconf.h
include/zlib.h
"

neoterm_step_post_get_source() {
	pushd toolchains/llvm/prebuilt/linux-x86_64/sysroot/
	for patch in $NEOTERM_SCRIPTDIR/ndk-patches/$NEOTERM_PKG_VERSION/*.patch; do
		echo "Applying ndk patch: $(basename $patch)"
		test -f "$patch" && sed \
			-e "s%\@NEOTERM_APP_PACKAGE\@%${NEOTERM_APP_PACKAGE}%g" \
			-e "s%\@NEOTERM_BASE_DIR\@%${NEOTERM_BASE_DIR}%g" \
			-e "s%\@NEOTERM_CACHE_DIR\@%${NEOTERM_CACHE_DIR}%g" \
			-e "s%\@NEOTERM_HOME\@%${NEOTERM_ANDROID_HOME}%g" \
			-e "s%\@NEOTERM_PREFIX\@%${NEOTERM_PREFIX}%g" \
			"$patch" | patch --silent -p1
	done
	sed -i "s/define __ANDROID_API__ __ANDROID_API_FUTURE__/define __ANDROID_API__ $NEOTERM_PKG_API_LEVEL/" \
		usr/include/android/api-level.h
	grep -lrw usr/include/c++/v1 -e '<version>' | xargs -n 1 sed -i 's/<version>/\"version\"/g'
	popd
}

neoterm_step_make_install() {
	mkdir -p $NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX/lib \
		$NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX/include

	cp -Rf toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/include/* \
		$NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX/include


	find $NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX/include -name \*.orig -delete

	cp $NEOTERM_SCRIPTDIR/ndk-patches/{langinfo,libintl}.h $NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX/include/

	cp toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/lib/$NEOTERM_HOST_PLATFORM/$NEOTERM_PKG_API_LEVEL/*.o \
		$NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX/lib

	cp toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/lib/$NEOTERM_HOST_PLATFORM/libcompiler_rt-extras.a \
		$NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX/lib/

	NDK_ARCH=$NEOTERM_ARCH
	test $NDK_ARCH == 'i686' && NDK_ARCH='i386'

	# clang 13 requires libunwind on Android.
	cp toolchains/llvm/prebuilt/linux-x86_64/lib/clang/17/lib/linux/$NDK_ARCH/libatomic.a \
		$NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX/lib
	cp toolchains/llvm/prebuilt/linux-x86_64/lib/clang/17/lib/linux/$NDK_ARCH/libunwind.a \
		$NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX/lib

	# librt and libpthread are built into libc on android, so setup them as symlinks
	# to libc for compatibility with programs that users try to build:
	for lib in librt.so libpthread.so libutil.so; do
		echo 'INPUT(-lc)' > $NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX/lib/$lib
	done
	unset lib
}
