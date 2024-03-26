NEOTERM_PKG_HOMEPAGE=https://developer.android.com/tools/sdk/ndk/index.html
NEOTERM_PKG_DESCRIPTION="Multilib binaries for cross-compilation"
NEOTERM_PKG_LICENSE="NCSA"
NEOTERM_PKG_MAINTAINER="@neoterm"
# Version should be equal to NEOTERM_NDK_{VERSION_NUM,REVISION} in
# scripts/properties.sh
NEOTERM_PKG_VERSION=26c
NEOTERM_PKG_SRCURL=https://dl.google.com/android/repository/android-ndk-r${NEOTERM_PKG_VERSION}-linux.zip
NEOTERM_PKG_SHA256=6d6e659834d28bb24ba7ae66148ad05115ebbad7dabed1af9b3265674774fcf6
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_NO_STATICSPLIT=true
NEOTERM_PKG_BUILD_IN_SRC=true

prepare_libs() {
	local ARCH="$1"
	local SUFFIX="$2"
	local NDK_SUFFIX=$SUFFIX

	if [ $ARCH = x86 ] || [ $ARCH = x86_64 ]; then
	    NDK_SUFFIX=$ARCH
	fi

	mkdir -p $NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX/$SUFFIX/lib
	mkdir -p $NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX/opt/ndk-multilib/$SUFFIX/lib
	local BASEDIR=toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/lib/$SUFFIX/
	cp $BASEDIR/${NEOTERM_PKG_API_LEVEL}/*.o $NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX/$SUFFIX/lib
	cp $BASEDIR/${NEOTERM_PKG_API_LEVEL}/lib{c,dl,log,m}.so $NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX/opt/ndk-multilib/$SUFFIX/lib
	cp $BASEDIR/libc++_shared.so $NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX/$SUFFIX/lib
	cp $BASEDIR/lib{c,dl,m}.a $NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX/opt/ndk-multilib/$SUFFIX/lib
	cp $BASEDIR/lib{c++_static,c++abi}.a $NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX/$SUFFIX/lib
	echo 'INPUT(-lc++_static -lc++abi)' > $NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX/$SUFFIX/lib/libc++_shared.a

	local f
	for f in lib{c,dl,log,m}.so lib{c,dl,m}.a; do
		ln -sfT $NEOTERM_PREFIX/opt/ndk-multilib/$SUFFIX/lib/${f} \
			$NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX/$SUFFIX/lib/${f}
	done

	if [ $ARCH == "x86" ]; then
		LIBATOMIC=toolchains/llvm/prebuilt/linux-x86_64/lib/clang/*/lib/linux/i386
	elif [ $ARCH == "arm64" ]; then
		LIBATOMIC=toolchains/llvm/prebuilt/linux-x86_64/lib/clang/*/lib/linux/aarch64
	else
		LIBATOMIC=toolchains/llvm/prebuilt/linux-x86_64/lib/clang/*/lib/linux/$ARCH
	fi

	cp $LIBATOMIC/libatomic.a $NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX/$SUFFIX/lib/

	cp $LIBATOMIC/libunwind.a $NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX/$SUFFIX/lib/
}

add_cross_compiler_rt() {
	RT_PREFIX=toolchains/llvm/prebuilt/linux-x86_64/lib/clang/*/lib/linux
	RT_OPT_DIR=$NEOTERM_PREFIX/opt/ndk-multilib/cross-compiler-rt
	mkdir -p $NEOTERM_PKG_MASSAGEDIR/$RT_OPT_DIR
	cp $RT_PREFIX/* $NEOTERM_PKG_MASSAGEDIR/$RT_OPT_DIR || true
}

neoterm_step_make_install() {
	prepare_libs "arm" "arm-linux-androideabi"
	prepare_libs "arm64" "aarch64-linux-android"
	prepare_libs "x86" "i686-linux-android"
	prepare_libs "x86_64" "x86_64-linux-android"
	add_cross_compiler_rt
}

neoterm_step_post_massage() {
	local triple f
	for triple in aarch64-linux-android arm-linux-androideabi i686-linux-android x86_64-linux-android; do
		for f in lib{c,dl,log,m}.so lib{c,dl,m}.a; do
			rm -f ${triple}/lib/${f}
		done
	done
}

neoterm_step_create_debscripts() {
	local f
	for f in postinst prerm; do
		sed -e "s|@NEOTERM_PREFIX@|${NEOTERM_PREFIX}|g" \
			-e "s|@NEOTERM_PACKAGE_FORMAT@|${NEOTERM_PACKAGE_FORMAT}|g" \
			$NEOTERM_PKG_BUILDER_DIR/postinst-header.in > "${f}"
	done
	sed 's|@COMMAND@|ln -sf "'$NEOTERM_PREFIX'/opt/ndk-multilib/$triple/lib/$so" "'$NEOTERM_PREFIX'/\$triple/lib"|' \
		$NEOTERM_PKG_BUILDER_DIR/postinst-alien.in >> postinst
	sed 's|@COMMAND@|rm -f "'$NEOTERM_PREFIX'/$triple/lib/$so"|' \
		$NEOTERM_PKG_BUILDER_DIR/postinst-alien.in >> prerm
	chmod 0700 postinst prerm
}

